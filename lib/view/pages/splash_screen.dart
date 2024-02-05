import 'package:flutter/material.dart';
import 'package:recipe_ai/repository/auth_repository.dart';
import 'package:recipe_ai/res/app_colors.dart';
import 'package:recipe_ai/utils/routes/routes_Name.dart';
import 'package:recipe_ai/utils/utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  _navigateToHome() {
    Navigator.pushReplacementNamed(context, RoutesName.home);
    Utils.flushBarSuccessMessage("Welcome Back!!", context);
  }

  _navigateToLogin() {
    Navigator.pushReplacementNamed(context, RoutesName.welcome);
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      AuthRepository().isUserLoggedIn() ? _navigateToHome() : _navigateToLogin();
    },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Image.asset("assets/pictures/splash_logo.png", width: 350, height: 350,)),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          const CircularProgressIndicator(
            color: AppColors.orangeColor,
          ),
        ],
      ),
    );
  }
}
