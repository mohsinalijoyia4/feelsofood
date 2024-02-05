import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';/
import 'package:path_provider/path_provider.dart';
import 'package:recipe_ai/res/app_colors.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;

enum Type { History, Present }

class AiChatBubble extends StatelessWidget {
  final Type type;
  final String message;
  final String? image;
  AiChatBubble(
      {super.key, required this.message, this.image, required this.type});

  File? localImageFile;
  Future<void> _downloadImage() async {
    print(image);
    final http.Response response = await http.get(Uri.parse(image ?? ""));
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/recipe_image.jpg');
    print(response.body);
    await file.writeAsBytes(response.bodyBytes);

    localImageFile = file;
  }

  void _shareRecipe(BuildContext context) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              contentPadding: const EdgeInsets.all(16),
              alignment: Alignment.center,
              backgroundColor: AppColors.backgroundColor,
              content: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 180,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Downloading Image",
                      style: TextStyle(fontSize: 21),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Center(
                      child: CircularProgressIndicator(
                        color: AppColors.orangeColor,
                      ),
                    )
                  ],
                ),
              ),
            ));
    await _downloadImage();
    Navigator.pop(context);
    XFile? file = XFile(localImageFile?.path ?? "");
    Share.shareXFiles(
      [file],
      // subject:'Check out this delicious recipe: \n  $message',
      text: 'Check out this delicious recipe: \n  $message',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.87,
        margin: const EdgeInsets.only(top: 20, left: 10),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  foregroundColor: AppColors.orangeColor,
                  backgroundColor: AppColors.orangeColor,
                  child: Image.asset("assets/pictures/circular_avatar.png"),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  "Recipe-Ai",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: AppColors.blackColor),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            type == Type.Present
                ? AnimatedTextKit(
                    totalRepeatCount: 1,
                    isRepeatingAnimation: false,
                    repeatForever: false,
                    animatedTexts: [
                      TyperAnimatedText(
                        message,
                        textStyle: const TextStyle(
                            color: AppColors.blackColor, fontSize: 13),
                        speed: const Duration(milliseconds: 50),
                      ),
                    ],
                  )
                : Text(
                    message,
                    style: const TextStyle(
                        color: AppColors.blackColor, fontSize: 13),
                  ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () async {
                    if (message.trim() != "error") {
                      await Clipboard.setData(ClipboardData(text: message))
                          .then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Recipe is copied")));
                      });
                    }
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.copy_rounded,
                        color: AppColors.blackColor,
                        size: 15,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Copy",
                        style: TextStyle(
                            color: AppColors.blackColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (message.trim() != "error") {
                      if (image != "") {
                        _shareRecipe(context);
                      }
                    }
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.share_rounded,
                        color: AppColors.blackColor,
                        size: 15,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Share",
                        style: TextStyle(
                            color: AppColors.blackColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Text(
                  "Ai-Recipe-Generator",
                  style: TextStyle(
                      color: AppColors.blackColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w400),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
