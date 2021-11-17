import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    Key? key,
    required this.child,
    required this.backgroundColor,
    required this.onPressed,
    this.borderRadius = 2.0,
    this.height = 50.0,
  }) : super(key: key);

  final Widget child;
  final Color backgroundColor;
  final double borderRadius;
  final double height;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        child: child,
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(
            onPressed == null ? Colors.grey : backgroundColor,
          ),
        ),
      ),
    );
  }
}
