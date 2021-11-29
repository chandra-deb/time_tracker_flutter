import 'package:flutter/material.dart';
import 'package:time_tracker/app/widgets/custom_elevated_button.dart';

class SocialSignInButton extends CustomElevatedButton {
  SocialSignInButton({
    Key? key,
    required String assetsPath,
    required String text,
    required Color backgroundColor,
    required Color textColor,
    required VoidCallback? onPressed,
  }) : super(
          key: key,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Image.asset(assetsPath),
            Text(
              text,
              style: TextStyle(color: textColor, fontSize: 16),
            ),
            Opacity(
              opacity: 0,
              child: Image.asset(assetsPath),
            ),
          ]),
          backgroundColor: backgroundColor,
          onPressed: onPressed,
        );
}
