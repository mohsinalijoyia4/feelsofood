import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:recipe_ai/model/History.dart';
import 'package:recipe_ai/res/app_colors.dart';
import 'package:recipe_ai/view/components/ai_chat_bubble.dart';
import 'package:recipe_ai/view/components/user_chat_bubble.dart';

class HistoryDetails extends StatelessWidget {
  final HistoryModel model;
  const HistoryDetails({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          title: const Text(
            "Recipe Details",
            style: TextStyle(
                color: AppColors.blackColor,
                fontWeight: FontWeight.w500,
                fontSize: 17),
          ),
          backgroundColor: AppColors.backgroundColor,
          centerTitle: true,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            const UserChatBubble(message: "Here is your recipe..."),
            const SizedBox(
              height: 20,
            ),
            CachedNetworkImage(
              imageUrl: model.imageUrl,
              placeholder: (context, url) => Container(
                width: double.infinity,
                height: 360,
                color: Colors.white,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: CircularProgressIndicator(
                        color: AppColors.orangeColor,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Loading Image")
                  ],
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            AiChatBubble(
              message: model.description,
              image: model.imageUrl,
              type: Type.History,
            ),
            const SizedBox(
              height: 10,
            ),
          ]),
        ));
  }
}
