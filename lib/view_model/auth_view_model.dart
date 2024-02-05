import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipe_ai/repository/auth_repository.dart';
import 'package:recipe_ai/res/app_colors.dart';
import 'package:recipe_ai/res/app_textStyle.dart';
import '../utils/routes/routes_Name.dart';
import '../utils/utils.dart';

class AuthViewModel with ChangeNotifier {
  final _authRepo = AuthRepository();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  setLoading(value) {
    _isLoading = value;
    notifyListeners();
  }

  String getUserUid() {
    return _authRepo.userUid();
  }

  registerUser(
      {required BuildContext context,
      required String email,
      required String password,
      required String name}) {
    setLoading(true);
    _authRepo
        .registerUser(email: email, password: password, name: name)
        .then((value) {
      setLoading(false);
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                contentPadding: const EdgeInsets.all(16),
                alignment: Alignment.center,
                backgroundColor: AppColors.backgroundColor,
                content: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 300,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Image(
                        image: AssetImage("assets/icons/tick.png"),
                        height: 130,
                        width: 130,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Congratulations!",
                        style: AppTextStyle.authHintText(Colors.black),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const CircularProgressIndicator(
                        color: AppColors.orangeColor,
                      ),
                    ],
                  ),
                ),
              ));
      Timer(const Duration(seconds: 2), () {
        Navigator.pushNamed(context, RoutesName.home);
      });
      Utils.flushBarSuccessMessage("Welcome!!", context);
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
    });
  }

  loginUser(
      {required BuildContext context,
      required String email,
      required String password}) {
    setLoading(true);

    _authRepo.loginUser(email: email, password: password).then((value) {
      setLoading(false);
      Navigator.pushNamedAndRemoveUntil(
        context,
        RoutesName.home,
        (route) => false,
      );
      Utils.flushBarSuccessMessage("Welcome Back!!", context);
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
    });
  }

  signOutUser({required BuildContext context}) {
    _authRepo.logoutUser().then((value) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        RoutesName.login,
        (route) => false,
      );
      Utils.flushBarSuccessMessage("Logout successfully", context);
    }).onError((error, stackTrace) {
      Utils.flushBarSuccessMessage("Logout Failed", context);
    });
  }

  bool checkIsUserLoggedIn() {
    return _authRepo.isUserLoggedIn();
  }
}
