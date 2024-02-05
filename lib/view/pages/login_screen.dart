import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:recipe_ai/ads_controller.dart';
import 'package:recipe_ai/res/app_colors.dart';
import 'package:recipe_ai/res/app_textStyle.dart';
import 'package:recipe_ai/utils/routes/routes_Name.dart';
import 'package:recipe_ai/utils/utils.dart';
import 'package:recipe_ai/view/components/auth_custom_buttons.dart';
import 'package:recipe_ai/view/components/auth_custom_textfield.dart';
import 'package:recipe_ai/view_model/auth_view_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var myCont = Get.put(MyController());
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
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              Text(
                "Login Account",
                style: AppTextStyle.authHeadings(AppColors.blackColor),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              CustomTextField(
                showText: false,
                type: AuthTextFieldType.email,
                controller: emailController,
                hintText: "Email",
                icon: const Icon(
                  Icons.email_outlined,
                  color: AppColors.blackColor,
                ),
              ),
              CustomTextField(
                type: AuthTextFieldType.password,
                controller: passwordController,
                hintText: "Password",
                icon: const Icon(
                  Icons.lock_outlined,
                  color: AppColors.blackColor,
                ),
                showText: true,
              ),
              CustomButton(
                  text: "Sign In",
                  onPressed: () {
                    if (emailController.text.trim().isEmpty) {
                      setState(() {
                        isLoading = false;
                      });
                      Utils.flushBarErrorMessage(
                          "Email Field cannot be empty.", context);
                    } else if (passwordController.text.trim().isEmpty) {
                      Utils.flushBarErrorMessage(
                          "Password Field cannot be empty.", context);
                      setState(() {
                        isLoading = false;
                      });
                    } else if (passwordController.text.trim().length < 6) {
                      Utils.flushBarErrorMessage(
                          "Password must be 6 characters long.", context);
                      setState(() {
                        isLoading = false;
                      });
                    } else {
                      AuthViewModel().loginUser(
                          context: context,
                          email: emailController.text.toString(),
                          password: passwordController.text.toString());
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                  color: AppColors.orangeColor,
                  loading: false),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: 1,
                decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [
                      AppColors.whiteColor,
                      AppColors.orangeColor,
                      AppColors.whiteColor
                    ]),
                    borderRadius: BorderRadius.circular(10)),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(
                          fontSize: 14,
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.w400),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RoutesName.signup);
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                            fontSize: 14,
                            color: AppColors.orangeColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Obx(() => Container(
                    child: myCont.isAdLoaded.value && myCont.nativeAd != null
                        ? ConstrainedBox(
                            constraints: const BoxConstraints(
                                maxHeight: 100, minHeight: 100),
                            child: AdWidget(ad: myCont.nativeAd!))
                        : Text(
                            "Ad is not Loaded yet",
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
