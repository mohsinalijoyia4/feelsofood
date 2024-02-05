import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:recipe_ai/utils/routes/routes_Name.dart';
import 'package:recipe_ai/view/components/auth_custom_buttons.dart';
import 'package:recipe_ai/view_model/home_view_model.dart';
import 'package:recipe_ai/res/app_colors.dart';
import 'package:recipe_ai/view/components/user_chat_bubble.dart';

import '../components/ai_chat_bubble.dart';

class AskRecipe extends StatefulWidget {
  const AskRecipe({super.key});

  @override
  State<AskRecipe> createState() => _AskRecipeState();
}

class _AskRecipeState extends State<AskRecipe> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<HomeRepository>().getRecipe(context);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // context.read<HomeRepository>().generatedResponse = "";
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text(
          "Ask Recipe",
          style: TextStyle(
              color: AppColors.blackColor,
              fontWeight: FontWeight.w500,
              fontSize: 17),
        ),
        backgroundColor: AppColors.backgroundColor,
        centerTitle: true,
        elevation: 0,
      ),
      body: Consumer<HomeRepository>(builder: (context, value, child) {
        return value.isLoading
            ? SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Lottie.asset('assets/icons/animation.json'),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(
                        "Generating Recipe",
                        style: TextStyle(
                            color: AppColors.backgroundColor,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              )
            : SingleChildScrollView(
                child: Column(children: [
                  const UserChatBubble(message: "Here is your recipe..."),
                  const SizedBox(
                    height: 20,
                  ),
                  if (value.isImageLoading)
                    Container(
                      width: double.infinity,
                      height: 360,
                      color: Colors.white,
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: CircularProgressIndicator(
                              color: AppColors.orangeColor,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text("Loading Image")
                        ],
                      ),
                    ),
                  if ((value.imageUrl != "null" || value.imageUrl.isNotEmpty) &&
                      !value.isImageLoading)
                    CachedNetworkImage(
                      imageUrl: value.imageUrl,
                      placeholder: (context, url) => Container(
                        width: double.infinity,
                        height: 360,
                        color: Colors.white,
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: CircularProgressIndicator(
                                color: AppColors.orangeColor,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text("Loading Image")
                          ],
                        ),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  if (value.generatedResponse != "")
                    AiChatBubble(
                      message: value.generatedResponse,
                      image: value.imageUrl,
                      type: Type.Present,
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: SizedBox(
                      width: 200,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: CustomButton(
                            text: "Save Recipe",
                            onPressed: () async {
                              if (value.generatedResponse.trim() != "error" &&
                                  value.imageUrl != "") {
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20.0))),
                                          contentPadding:
                                              const EdgeInsets.all(16),
                                          alignment: Alignment.center,
                                          backgroundColor:
                                              AppColors.backgroundColor,
                                          content: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.9,
                                            height: 180,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Saving Recipe",
                                                  style:
                                                      TextStyle(fontSize: 21),
                                                ),
                                                const SizedBox(
                                                  height: 25,
                                                ),
                                                Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    color:
                                                        AppColors.orangeColor,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ));
                                await value
                                    .addInFirebaseFireStore(
                                        value.foodNameForFirebase)
                                    .then((value) {
                                  Navigator.pop(context);
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text("Recipe Added to history")));
                                Navigator.pop(context);
                              }
                            },
                            color: AppColors.orangeColor,
                            loading: false),
                      ),
                    ),
                  ),
                ]),
              );
      }),
    );
  }
}
