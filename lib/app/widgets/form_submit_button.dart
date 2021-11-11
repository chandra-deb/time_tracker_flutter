import 'package:flutter/material.dart';
import 'package:time_tracker/app/widgets/custom_elevated_button.dart';

class FormSubmitButton extends CustomElevatedButton {
  FormSubmitButton({
    Key? key,
    required String text,
    required VoidCallback onPressed,
  }) : super(
          key: key,
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
          height: 44.0,
          // color: Colors.indigo,
          borderRadius: 4.0,
          onPressed: onPressed,
          backgroundColor: Colors.deepOrange,
        );
}
