import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:time_tracker/app/widgets/platform_alert_dialog.dart';

class FirebaseExceptionDialog extends PlatformAlertDialog {
  FirebaseExceptionDialog({
    required String title,
    required FirebaseAuthException exception,
    Key? key,
  }) : super(
          title: title,
          content: _message(exception),
          defaultActionText: "Ok",
          key: key,
        );

  static String _message(FirebaseAuthException exception) {
    // return exception.message.toString();
    return _errors[exception.code].toString();
  }

  static final Map<String, String> _errors = {
    "network_error": "No Internet! Connect to the internet and try again!",
    "invalid-email": "This is not a valid email address!",
    "user-disabled": "Your account is suspended!",
    "user-not-found": "There is no user with this credentials",
    "wrong-password": "There is no user with this credentials",

    "email-already-in-use":
        "This email is already in you. you can not create more than one account with an email.",
    "network-request-failed":
        "There is no internet connection.\nConnect to the internet and try again later"

    /// - **operation-not-allowed**:
    ///  - Thrown if email/password accounts are not enabled. Enable
    ///    email/password accounts in the Firebase Console, under the Auth tab.
    // - **weak-password**:
    ///  - Thrown if the password is not strong enough.
  };
}
