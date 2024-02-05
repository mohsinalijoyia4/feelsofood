import 'package:flutter/material.dart';
import 'package:recipe_ai/res/app_colors.dart';
import 'package:recipe_ai/res/app_textStyle.dart';

class ReqTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType type;
  final ValueChanged<String>? onFieldSubmitted;

  ReqTextField(
      {super.key,
        required this.controller,
        required this.hintText,
      this.type = TextInputType.text,
        this.onFieldSubmitted
  });

  @override
  State<ReqTextField> createState() => _ReqTextFieldState();
}

class _ReqTextFieldState extends State<ReqTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.type,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: AppTextStyle.reqHintText(AppColors.blackColor,),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.blackColor, width: 3),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.blackColor, width: 3),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.blackColor, width: 3),
        ),
        filled: true,
        fillColor: AppColors.whiteColor,
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }
}
