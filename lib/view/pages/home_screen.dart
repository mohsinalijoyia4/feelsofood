import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:recipe_ai/ads_controller.dart';
import 'package:recipe_ai/view_model/home_view_model.dart';
import 'package:recipe_ai/res/app_colors.dart';
import 'package:recipe_ai/res/app_textStyle.dart';
import 'package:recipe_ai/utils/routes/routes_Name.dart';
import 'package:recipe_ai/utils/utils.dart';
import 'package:recipe_ai/view/components/auth_custom_buttons.dart';
import 'package:recipe_ai/view/components/req_textfield.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController mealTypeController = TextEditingController();
  final TextEditingController ingredientsController = TextEditingController();
  final TextEditingController dietaryController = TextEditingController();
  final TextEditingController servingsController = TextEditingController();

  FocusNode mealType = FocusNode();
  FocusNode ingredients = FocusNode();
  FocusNode dietary = FocusNode();
  var myCont = Get.put(MyControllerHome());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myCont.loadAd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundColor,
          elevation: 0.0,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, RoutesName.settings);
              },
              icon: const Icon(
                Icons.settings,
                color: AppColors.blackColor,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
          ],
        ),
        body: Consumer<HomeRepository>(builder: (context, value, child) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Center(
                    child: Image.asset(
                  "assets/pictures/splash_logo.png",
                  width: 350,
                  height: 200,
                )),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.88,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppColors.blackColor, width: 3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      focusNode: mealType,
                      value: value.currentDinner,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      underline: null,
                      items: value.mealType.map((String value1) {
                        return DropdownMenuItem<String>(
                          value: value1,
                          child: Text(value1),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          value.updateMealType(newValue);
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border.all(color: AppColors.blackColor, width: 3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: TextField(
                                focusNode: ingredients,
                                controller: ingredientsController,
                                onSubmitted: (value1) {
                                  if (value1.isNotEmpty) {
                                    value.addIngredient(value1);
                                    ingredientsController.clear();
                                    Utils.shiftFocusOfField(
                                        context, ingredients, ingredients);
                                  }
                                },
                                decoration: InputDecoration(
                                  hintText: "Enter Ingredients",
                                  hintStyle: AppTextStyle.reqHintText(
                                    AppColors.blackColor,
                                  ),
                                  filled: true,
                                  fillColor: AppColors.whiteColor,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 16),
                                ),
                              ),
                            ),
                            if (value.ingredients.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 3),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Wrap(
                                    children: [
                                      ...value.ingredients
                                          .asMap()
                                          .entries
                                          .map((e) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10, bottom: 1, top: 3),
                                          child: Chip(
                                            label: Text(
                                              e.value,
                                              style: const TextStyle(
                                                  color: AppColors.orangeColor),
                                            ),
                                            deleteIcon: const Icon(
                                              Icons.close,
                                              color: Colors.orange,
                                            ),
                                            backgroundColor: AppColors
                                                .orangeColor
                                                .withOpacity(0.4),
                                            onDeleted: () {
                                              value.removeIngredient(e.key);
                                            },
                                          ),
                                        );
                                      })
                                    ],
                                  ),
                                ),
                              )
                          ],
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (ingredientsController.text.isNotEmpty) {
                          value.addIngredient(ingredientsController.text);
                          ingredientsController.clear();
                          Utils.shiftFocusOfField(
                              context, ingredients, ingredients);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.08,
                            vertical: 10),
                        foregroundColor: AppColors.orangeColor,
                        backgroundColor: AppColors.orangeColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "Add",
                        style: TextStyle(
                          color: AppColors.whiteColor,
                          fontSize: 16,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 14,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.88,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppColors.blackColor, width: 3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            focusNode: dietary,
                            value: value.dietary_pref,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            underline: null,
                            items: value.dietaryList.map((String value1) {
                              return DropdownMenuItem<String>(
                                value: value1,
                                child: Text(value1),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                value.updateDietary("Dietary Preferences");
                                value.addDietary(newValue);
                              });
                            },
                          ),
                        ),
                      ),
                      if (value.selectedPreference.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 3),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Wrap(
                              children: [
                                ...value.selectedPreference
                                    .asMap()
                                    .entries
                                    .map((e) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        right: 10, bottom: 1, top: 3),
                                    child: Chip(
                                      label: Text(
                                        e.value,
                                        style: const TextStyle(
                                            color: AppColors.orangeColor),
                                      ),
                                      deleteIcon: const Icon(
                                        Icons.close,
                                        color: Colors.orange,
                                      ),
                                      backgroundColor: AppColors.orangeColor
                                          .withOpacity(0.4),
                                      onDeleted: () {
                                        value.removeDietary(e.key);
                                      },
                                    ),
                                  );
                                })
                              ],
                            ),
                          ),
                        )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.88,
                  child: ReqTextField(
                      controller: servingsController,
                      type: TextInputType.number,
                      hintText: "Number of servings"),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                CustomButton(
                    text: "Generate Recipe",
                    onPressed: () {
                      if (value.currentDinner == "Select Meal Type" ||
                          value.currentDinner.isEmpty) {
                        Utils.flushBarErrorMessage(
                            "Please Select a meal type", context);
                        return;
                      }

                      if (value.ingredients.isEmpty) {
                        Utils.flushBarErrorMessage(
                            "Please add Ingredients", context);
                        return;
                      }

                      if (value.ingredients.length < 3) {
                        Utils.flushBarErrorMessage(
                            "Please add at-least 3 Ingredients", context);
                        return;
                      }

                      if (value.selectedPreference.isEmpty) {
                        Utils.flushBarErrorMessage(
                            "Please Select Dietary Preference", context);
                        return;
                      }

                      if (servingsController.text.trim().isEmpty) {
                        Utils.flushBarErrorMessage(
                            "Please add Number of Servings", context);
                        return;
                      }

                      int numberOfServings =
                          int.parse(servingsController.text.trim().toString());

                      if (numberOfServings == 0) {
                        Utils.flushBarErrorMessage(
                            "Number of Servings should be at-least 1", context);
                        return;
                      }
                      value.generatedResponse = "";
                      value.imageUrl = "";
                      value.updateNumberOfServings(
                          servingsController.text.toString());
                      Navigator.pushNamed(context, RoutesName.askRecipe);
                    },
                    color: AppColors.orangeColor,
                    loading: false),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Obx(() => Container(
                      child: myCont.isAdLoaded.value
                          ? ConstrainedBox(
                              constraints: const BoxConstraints(
                                  maxHeight: 100, minHeight: 100),
                              child: AdWidget(ad: myCont.nativeAd!))
                          : Text(
                              "Ad is not Loaded yet",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                    ))
              ],
            ),
          );
        }));
  }
}
