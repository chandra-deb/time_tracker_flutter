import 'package:flutter/material.dart';
import 'package:time_tracker/app/widgets/platform_alert_dialog.dart';
import 'package:time_tracker/services/auth_provider.dart';
import './utils/show_snack_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  void _signOut(BuildContext context) async {
    final auth = AuthProvider.of(context);

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
      _signOut(context);
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
