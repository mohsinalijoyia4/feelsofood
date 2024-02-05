import 'package:flutter/material.dart';
import 'package:recipe_ai/utils/routes/routes_Name.dart';
import 'package:recipe_ai/view/pages/askRecipe_screen.dart';
import 'package:recipe_ai/view/pages/check_auth_screen.dart';
import 'package:recipe_ai/view/pages/history_screen.dart';
import 'package:recipe_ai/view/pages/home_screen.dart';
import 'package:recipe_ai/view/pages/login_screen.dart';
import 'package:recipe_ai/view/pages/register_screen.dart';
import 'package:recipe_ai/view/pages/settings_screen.dart';
import 'package:recipe_ai/view/pages/splash_screen.dart';
import 'package:recipe_ai/view/pages/welcome.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.recipeHistory:
        return MaterialPageRoute(builder: (context) => const History());
      case RoutesName.splash:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case RoutesName.welcome:
        return MaterialPageRoute(builder: (context) => const WelcomeScreen());
      case RoutesName.home:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case RoutesName.checkAuth:
        return MaterialPageRoute(
            builder: (context) => const CheckAuthentication());
      case RoutesName.login:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case RoutesName.settings:
        return MaterialPageRoute(builder: (context) => const SettingsScreen());
      case RoutesName.askRecipe:
        return MaterialPageRoute(builder: (context) => const AskRecipe());
      case RoutesName.signup:
        return MaterialPageRoute(builder: (context) => const RegisterScreen());
      default:
        return MaterialPageRoute(
          builder: (context) {
            return const Scaffold(
              body: Center(
                child: Text("No route Defined"),
              ),
            );
          },
        );
    }
  }
}
