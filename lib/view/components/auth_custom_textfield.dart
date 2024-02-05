import 'package:flutter/material.dart';

import '../../res/app_colors.dart';
import '../../res/app_textStyle.dart';

enum AuthTextFieldType {
  email,
  password,
  name,
}

class CustomTextField extends StatefulWidget {
  final AuthTextFieldType type;
  final TextEditingController controller;
  final String hintText;
  bool showText;
  final Icon icon;

  CustomTextField(
      {super.key,
      required this.type,
      required this.controller,
      required this.hintText,
      required this.showText,
      required this.icon});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.showText,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: AppTextStyle.authHintText(AppColors.blackColor),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.blackColor),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.blackColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.blackColor),
          ),
          prefixIcon: widget.icon,
          suffixIcon: widget.type == AuthTextFieldType.password
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.showText = !widget.showText;
                    });
                  },
                  child: Icon(
                    widget.showText ? Icons.visibility : Icons.visibility_off,
                    color: AppColors.blackColor,
                  ),
                )
              : null,
          filled: true,
          fillColor: AppColors.whiteColor,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }
}
