import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:recipe_ai/ads_controller.dart';
import 'package:recipe_ai/repository/auth_repository.dart';
import 'package:recipe_ai/res/app_colors.dart';
import 'package:recipe_ai/utils/routes/routes_Name.dart';
import 'package:recipe_ai/utils/utils.dart';
import 'package:recipe_ai/view/components/auth_custom_buttons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../res/app_textStyle.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var myCont = Get.put(MyControllerSetting());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myCont.loadAd();
  }

  Uri aboutUsUrl =
      Uri.parse("https://sites.google.com/view/recipegeneratorai/about-us");
  Uri privacyUrl = Uri.parse(
      "https://sites.google.com/view/recipegeneratorai/privacy-policy");

  @override
  Widget build(BuildContext context) {
    double adHeight = MediaQuery.of(context).size.height * 0.21;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          // Code of gradient effect
          Align(
            alignment: Alignment.center,
            child: Container(
              color: Colors.white.withOpacity(1),
            ),
          ),
          Image.asset("assets/pictures/settingspage_Image.png"),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.37,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withOpacity(0.5),
                    Colors.white.withOpacity(0.7),
                    AppColors.whiteColor.withOpacity(1),
                  ]),
            ),
          ),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withOpacity(0.8),
                    AppColors.backgroundColor.withOpacity(0.3),
                    AppColors.backgroundColor.withOpacity(0.8),
                  ]),
            ),
          ),

          // Actual Code,

          // Back Button
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 15),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.blackColor,
                    size: 22,
                  ),
                ),
              ),
            ],
          ),

          // Circular Avatar
          Positioned(
            top: MediaQuery.of(context).size.height * 0.12,
            left: MediaQuery.of(context).size.width * 0.05,
            child: Column(
              children: [
                Row(children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.transparent,
                    child: Image.asset(
                      "assets/pictures/circular_avatar.png",
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        FirebaseAuth.instance.currentUser?.displayName ??
                            "example@gmail.com",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: AppColors.blackColor,
                        ),
                      ),
                      Text(
                        FirebaseAuth.instance.currentUser?.email ??
                            "example@gmail.com",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.blackColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ]),
              ],
            ),
          ),

          // Settings List
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 25),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, RoutesName.recipeHistory);
                  },
                  child: Row(children: [
                    Image.asset(
                      "assets/icons/history.png",
                      width: 30,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Text(
                      "History",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: AppColors.blackColor,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RoutesName.recipeHistory);
                      },
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.blackColor,
                        size: 22,
                      ),
                    ),
                  ]),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 25),
                child: GestureDetector(
                  onTap: () async {
                    if (!await canLaunchUrl(aboutUsUrl)) {
                      await launchUrl(aboutUsUrl);
                    } else {
                      Utils.flushBarErrorMessage(
                          "Enable to launch URL.", context);
                    }
                  },
                  child: Row(children: [
                    Image.asset(
                      "assets/icons/About.png",
                      width: 30,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Text(
                      "About App",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: AppColors.blackColor,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.blackColor,
                        size: 22,
                      ),
                    ),
                  ]),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 25),
                child: GestureDetector(
                  onTap: () async {
                    if (!await canLaunchUrl(privacyUrl)) {
                      await launchUrl(privacyUrl);
                    } else {
                      Utils.flushBarErrorMessage(
                          "Enable to launch URL.", context);
                    }
                  },
                  child: Row(children: [
                    Image.asset(
                      "assets/icons/shield-exclamation.png",
                      width: 30,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Text(
                      "Privacy",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: AppColors.blackColor,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.blackColor,
                        size: 22,
                      ),
                    ),
                  ]),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: CustomButton2(
                  text: "Sign Out",
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.0))),
                              contentPadding: const EdgeInsets.all(16),
                              alignment: Alignment.center,
                              backgroundColor: AppColors.whiteColor,
                              content: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height: 230,
                                child: Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.35,
                                      height: 2,
                                      color: AppColors.orangeColor,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Are you Sure?",
                                      style: AppTextStyle.authHintText(
                                          Colors.black),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.05,
                                    ),
                                    Text(
                                      "You can see your saved recipe when you sign in again.",
                                      style: AppTextStyle.logOutDialog(
                                          AppColors.blackColor),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.04,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomButton2(
                                          text: "Cancel",
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          color: AppColors.whiteColor,
                                          loading: false,
                                          textColor: AppColors.blackColor,
                                        ),
                                        CustomButton2(
                                          text: "Sign Out",
                                          onPressed: () {
                                            AuthRepository().logoutUser();
                                            Navigator.pushNamed(
                                                context, RoutesName.checkAuth);
                                            Utils.flushBarSuccessMessage(
                                                "Logout Successfully!",
                                                context);
                                          },
                                          color: AppColors.orangeColor,
                                          loading: false,
                                          textColor: AppColors.whiteColor,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ));
                  },
                  color: AppColors.orangeColor,
                  loading: false,
                  textColor: AppColors.whiteColor,
                )),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: adHeight),
              child: Obx(() => Container(
                    child: myCont.isAdLoaded.value && myCont.nativeAd != null
                        ? ConstrainedBox(
                            constraints: const BoxConstraints(
                                maxHeight: 100, minHeight: 100),
                            child: AdWidget(ad: myCont.nativeAd!))
                        : Text(
                            "Ad is not Loaded yet",
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
