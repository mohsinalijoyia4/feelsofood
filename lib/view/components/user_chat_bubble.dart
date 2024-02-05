import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import '../../res/app_colors.dart';

class UserChatBubble extends StatelessWidget {
  final String message;

  const UserChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.78,
        margin: const EdgeInsets.only(top: 20, right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(message.length > 30 ? 10 : 30),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 3, // changes position of shadow
            ),
          ],
        ),
        child: AnimatedTextKit(
          totalRepeatCount: 1,
          isRepeatingAnimation: false,
          repeatForever: false,
          animatedTexts: [
            TyperAnimatedText(
              message,
              textStyle:
                  const TextStyle(color: AppColors.blackColor, fontSize: 13),
              speed: const Duration(milliseconds: 50),
            ),
          ],
        ),
      ),
    );
  }
}
