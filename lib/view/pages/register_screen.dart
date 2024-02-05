import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_ai/res/app_colors.dart';
import 'package:recipe_ai/res/app_textStyle.dart';
import 'package:recipe_ai/utils/utils.dart';
import 'package:recipe_ai/view/components/auth_custom_buttons.dart';
import 'package:recipe_ai/view/components/auth_custom_textfield.dart';
import 'package:recipe_ai/view_model/auth_view_model.dart';

import '../../utils/routes/routes_Name.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthViewModel>(context, listen: true);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Text(
              "Create An Account",
              style: AppTextStyle.authHeadings(AppColors.blackColor),
            ),
            const SizedBox(
              height: 20,
            ),
            CircleAvatar(
              radius: 60,
              backgroundColor: AppColors.whiteColor,
              child: Image.asset("assets/pictures/circular_avatar.png"),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
              type: AuthTextFieldType.email,
              controller: emailController,
              hintText: "Email",
              showText: false,
              icon: const Icon(
                Icons.email_outlined,
                color: AppColors.blackColor,
              ),
            ),
            CustomTextField(
              type: AuthTextFieldType.email,
              controller: usernameController,
              hintText: "Username",
              showText: false,
              icon: const Icon(
                Icons.email_outlined,
                color: AppColors.blackColor,
              ),
            ),
            CustomTextField(
              type: AuthTextFieldType.password,
              controller: passwordController,
              hintText: "Password",
              showText: true,
              icon: const Icon(
                Icons.lock_outlined,
                color: AppColors.blackColor,
              ),
            ),
            CustomTextField(
              type: AuthTextFieldType.password,
              controller: confirmPasswordController,
              hintText: "Confirm Password",
              showText: true,
              icon: const Icon(
                Icons.lock_outlined,
                color: AppColors.blackColor,
              ),
            ),
            CustomButton(
                text: "Sign Up",
                onPressed: () {
                  if (usernameController.text.trim().isEmpty) {
                    Utils.flushBarErrorMessage(
                        "Name Field Cannot be empty", context);
                  } else if (emailController.text.trim().isEmpty) {
                    Utils.flushBarErrorMessage(
                        "Email Field Cannot be empty", context);
                  } else if (!Utils.checkEmail(
                      emailController.text.trim().toString())) {
                    Utils.flushBarErrorMessage(
                        "Please enter a valid email", context);
                  } else if (passwordController.text.trim().isEmpty) {
                    Utils.flushBarErrorMessage(
                        "Password Field Cannot be empty", context);
                  } else if (passwordController.text.trim().length < 6) {
                    Utils.flushBarErrorMessage(
                        "Password should be greater than 5 characters", context);
                  } else {
                    // every thing is fine
                    authProvider.registerUser(
                        context: context,
                        email: emailController.text.toString(),
                        password: passwordController.text.toString(),
                        name: usernameController.text.trim().toString());
                  }
                },
                color: AppColors.blackColor,
                loading: false),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account?",
                    style: TextStyle(
                        fontSize: 14,
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w400),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RoutesName.login);
                    },
                    child: const Text(
                      "Sign In",
                      style: TextStyle(
                          fontSize: 14,
                          color: AppColors.orangeColor,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
