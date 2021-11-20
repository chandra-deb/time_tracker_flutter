import 'package:flutter/material.dart';
import 'package:time_tracker/app/widgets/platform_alert_dialog.dart';
import './utils/show_snack_bar.dart';
import 'package:time_tracker/services/auth.dart';

class HomePage extends StatelessWidget {
  final AuthBase auth;

  const HomePage({
    required this.auth,
    Key? key,
  }) : super(key: key);

  void _signOut() async {
    await auth.signOut();
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    bool didRequestSignOut = await PlatformAlertDialog(
      content: "Do yoou really want to sign out?",
      defaultActionText: "Confirm",
      cancelActionText: "Cancel",
      title: "Sign Out",
    ).show(context);

    if (didRequestSignOut) {
      print(didRequestSignOut);
      _signOut();
      showSnackBar(context: context, text: "Logged out!");
    } else {
      print(didRequestSignOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        actions: [
          ElevatedButton(
            onPressed: () {
              _confirmSignOut(context);
            },
            child: Text(
              "Log Out",
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
