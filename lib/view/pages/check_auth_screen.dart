import 'package:flutter/material.dart';
import 'package:recipe_ai/res/app_colors.dart';
import 'package:recipe_ai/res/app_textStyle.dart';
import 'package:recipe_ai/utils/routes/routes_Name.dart';
import 'package:recipe_ai/view/components/auth_custom_buttons.dart';

class CheckAuthentication extends StatefulWidget {
  const CheckAuthentication({super.key});

  @override
  State<CheckAuthentication> createState() => _CheckAuthenticationState();
}

class _CheckAuthenticationState extends State<CheckAuthentication> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Create An Account",
              style: AppTextStyle.authHeadings(Colors.black),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            // Container(
            //   width: MediaQuery.of(context).size.width * 0.9,
            //   height: 60,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(20),
            //     color: AppColors.whiteColor,
            //   ),
            //   child: Center(
            //     child: Row(
            //       children: [
            //         SizedBox(
            //           width: MediaQuery.of(context).size.width * 0.16,
            //         ),
            //         Image.asset("assets/icons/google.png", width: 20, height: 20,),
            //         SizedBox(
            //           width: MediaQuery.of(context).size.width * 0.04,
            //         ),
            //         Text(
            //           "Continue With Google",
            //           style: AppTextStyle.authHintText(AppColors.blackColor),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: MediaQuery.of(context).size.height * 0.02,
            // ),
            CustomButton(
              text: "Sign In",
              onPressed: () {
                Navigator.pushNamed(context, RoutesName.login);
              },
              color: AppColors.orangeColor,
              loading: false,
              textColor: AppColors.blackColor,
            ),
            CustomButton(
              text: "Sign Up",
              onPressed: () {
                Navigator.pushNamed(context, RoutesName.signup);
              },
              color: AppColors.orangeColor,
              loading: false,
              textColor: AppColors.whiteColor,
            )
          ],
        ),
      ),
    );
  }
}
