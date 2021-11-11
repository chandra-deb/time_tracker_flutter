import 'package:flutter/material.dart';
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

  void _showSnackBar(String text, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        actions: [
          ElevatedButton(
            onPressed: () {
              _signOut();
              _showSnackBar("Logged Out!", context);
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
