
import 'package:flutter/material.dart';


class CustomButton extends StatelessWidget {
  final bool loading;
  final Color textColor;
  final String text;
  final GestureTapCallback onPressed;
  final Color color;
  final Icon icon;

  const CustomButton(
      {super.key,
        this.textColor = Colors.white,
        required this.text,
        required this.onPressed,
        required this.color,
        this.icon = const Icon(
          Icons.email_outlined,
          color: Colors.white,
        ),
        required this.loading});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: GestureDetector(
        onTap: () => onPressed(),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: color,
          ),
          child: loading
              ? const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ))
              : Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: TextStyle(
                      fontSize: 18,
                      color: textColor,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}






class CustomButton2 extends StatelessWidget {
  final bool loading;
  final Color textColor;
  final String text;
  final GestureTapCallback onPressed;
  final Color color;
  final Icon icon;

  const CustomButton2(
      {super.key,
        this.textColor = Colors.white,
        required this.text,
        required this.onPressed,
        required this.color,
        this.icon = const Icon(
          Icons.email_outlined,
          color: Colors.white,
        ),
        required this.loading});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: GestureDetector(
        onTap: () => onPressed(),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.35,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: color,
          ),
          child: loading
              ? const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ))
              : Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: TextStyle(
                      fontSize: 18,
                      color: textColor,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}