import 'dart:io';

import 'package:flutter/material.dart';
import 'package:recipe_ai/res/app_colors.dart';
import 'package:recipe_ai/utils/routes/routes_Name.dart';
import 'package:recipe_ai/view/components/auth_custom_buttons.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .05,
            ),
            Container(
              color: AppColors.backgroundColor,
              child: Column(
                children: [
                  Center(
                      child: Image.asset(
                    "assets/pictures/splash_logo.png",
                    width: 350,
                    height: 150,
                  )),
                  const Text(
                    "AI Recipe Wizard",
                    style: TextStyle(
                      color: AppColors.blackColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .02,
                  ),
                  const Text(
                    "Unleash the power of AI to create\npersonalized recipes!",
                    style: TextStyle(
                      color: AppColors.blackColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .05,
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    "assets/pictures/welcome_logo.png",
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * .5,
                  ),
                ),
                Positioned(
                    left: 20,
                    bottom: Platform.isAndroid ? 20 : 40,
                    child: CustomButton(
                        text: "Generate Recipe",
                        onPressed: () {
                          Navigator.pushNamed(context, RoutesName.checkAuth);
                        },
                        color: AppColors.orangeColor,
                        loading: false)),
                ClipPath(
                  clipper: Clip1Clipper(),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: MediaQuery.of(context).size.height * .5822,
                      width: MediaQuery.of(context).size.width,
                      color: AppColors.backgroundColor,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Clip1Clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 100);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
