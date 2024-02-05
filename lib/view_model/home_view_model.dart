import 'dart:convert';
import 'dart:developer';

import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipe_ai/utils/routes/routes_Name.dart';
import 'package:recipe_ai/utils/utils.dart';

class HomeRepository with ChangeNotifier{

  String generatedResponse = '''''';

  String imageUrl = "";
  String foodNameForFirebase = "";

  List<String> ingredients = [];
  List<String> mealType = ["Select Meal Type", "BreakFast", "Brunch", "Elevenses", "Lunch", "Supper", "Dinner"];
  String currentDinner = "Select Meal Type";
  int numberOfServings = 0;

  String dietary_pref = "Dietary Preferences";
  List<String> dietaryList = ["Dietary Preferences", "Vegan", "Halal", "Lactose intolerance", "Keto", "Paleo", "Gluten intolerance", "Diabetes", "Dairy-free", "Low carb", "Raw Foodism"];

  List<String> selectedPreference = [];
  bool _isLoading = false;
  bool get isLoading => _isLoading;


  bool _isImageLoading = true;
  bool get isImageLoading => _isImageLoading;
  setImageLoading(value){
    _isImageLoading = value;
    notifyListeners();
  }


  addIngredient(value){
    if(ingredients.contains(value)){
      updateUI();
      return;
    }

    ingredients.add(value);
    updateUI();
  }

  updateNumberOfServings(String servings){

    numberOfServings = int.parse(servings);
  }

  removeIngredient(index){
    ingredients.removeAt(index);
    updateUI();
  }



  addDietary(value){
    if(selectedPreference.contains(value)){
      updateUI();
      return;
    }

    selectedPreference.add(value);
    updateUI();
  }

  removeDietary(index){
    selectedPreference.removeAt(index);
    updateUI();
  }

  setLoading(value){
    _isLoading = value;
    notifyListeners();
  }

  updateUI(){
    notifyListeners();
  }

  void updateMealType(String? newValue) {
    currentDinner = newValue ?? "Select Meal Type";
  }

  void updateDietary(String? newValue) {
    dietary_pref = newValue ?? "Dietary Preferences";
  }




  void getRecipe(BuildContext context) async {
    final openAI = OpenAI.instance.build(token: "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", baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 25)),enableLog: true);

    String systemPrompt = ''' 
    Hey act as master chief (food cooking expert) and give recipe for a food based on 4 parameters 1) Meal Type 2) Ingredients 3) Dietary Preferences 4) Number of Servings. only give one recipe and use the below format for response
    Recipe Name : 
    Intgredients :
    Steps :
    (if have some tips) Tips :
    
    and if for some reason you failed to generate recipe then only send one word in response "error".
    ''';

    String userPrompt = '''
    Meal Type : $currentDinner,
    Ingredients : ${ingredients.toString()},
    Dietary Preference : ${selectedPreference.toString()},
    Number of servings : $numberOfServings
    ''';
    
    // generateImage("Beef and Potato Hash");
    // return;
    
    Messages userMessage = Messages(role: Role.user, content: userPrompt);
    Messages systemMessage = Messages(role: Role.system, content: systemPrompt);

    final request = ChatCompleteText(messages: [
      systemMessage,
      userMessage
    ], maxToken: 3000, model: Gpt4ChatModel());


    setLoading(true);


    final response = await openAI.onChatCompletion(request: request).catchError((err){
      if(err is OpenAIAuthError){
        if(context.mounted){

          Navigator.pushNamedAndRemoveUntil(context, RoutesName.home, (route) => false,);
          Utils.flushBarErrorMessage(err.data?.error.message.toString() ?? "Something went wrong", context);
        }
      }
      if(err is OpenAIRateLimitError){
        if(context.mounted){
          Navigator.pushNamedAndRemoveUntil(context, RoutesName.home, (route) => false,);
          Utils.flushBarErrorMessage(err.data?.error.message.toString() ?? "Something went wrong", context);
        }
      }
      if(err is OpenAIServerError){
        if(context.mounted){
          Navigator.pushNamedAndRemoveUntil(context, RoutesName.home, (route) => false,);
          Utils.flushBarErrorMessage(err.data?.error.message.toString() ?? "Something went wrong", context);
        }
      }

      return null;
    });


    setLoading(false);
    if(response != null) {
     generatedResponse = response.choices[0].message?.content.toString() ?? "Failed to Generate Response";
     log("=====");
     if(generatedResponse  == "error"){
       if(context.mounted) {
         Navigator.pushNamedAndRemoveUntil(context, RoutesName.home, (route) => false,);
         Utils.flushBarErrorMessage("Failed to Generate Recipe. Please Enter Valid Details", context);
       }

     }


     String foodName = getFoodNameFromResponse();
     if(foodName != "null") {
       generateImage(foodName);
     }
     log(generatedResponse);
     updateUI();
    }


  }


  String getFoodNameFromResponse(){
    // Define a regular expression pattern to match the recipe name
    RegExp regex = RegExp(r"Recipe Name : (.+)");
    Match? match = regex.firstMatch(generatedResponse);

    if (match != null) {
      String recipeName = match.group(1)!;
      return recipeName;
    } else {
      return "null";
    }

  }


  void generateImage(food) async {
    setImageLoading(true);
    String imagePrompt = "$food, Editorial Photography, Photography, Shot on 70mm lens, Depth of Field, Bokeh, DOF, Tilt Blur, Shutter Speed 1/1000, F/22, White Balance, 32k, Super-Resolution, white background";

    final openAI = OpenAI.instance.build(token: "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", baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 25)),enableLog: true);

    final request = GenerateImage(imagePrompt, 1,size: ImageSize.size1024,
        responseFormat: Format.url);
    final response = await openAI.generateImage(request);
    foodNameForFirebase = food;
    imageUrl = response?.data?[0]?.url.toString() ?? "null";
    setImageLoading(false);

       }

  // Encode string before saving to Firestore
  String encodeString(String originalString) {
    String encodedString = base64Encode(utf8.encode(originalString));
    return encodedString;
  }


  Future<void> addInFirebaseFireStore(foodName) async {
    FirebaseFirestore firebase = FirebaseFirestore.instance;
    var uid = FirebaseAuth.instance.currentUser?.uid ?? "";
    await firebase.collection("users").doc(uid).collection("history").add({
      "response" : encodeString(generatedResponse),
      "image" : imageUrl,
      "timestamp" : FieldValue.serverTimestamp(),
      "recipeName" : foodName
    });
  }

}