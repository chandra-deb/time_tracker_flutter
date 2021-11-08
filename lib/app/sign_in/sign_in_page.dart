import 'package:flutter/material.dart';

import 'package:time_tracker/app/sign_in/sign_in_button.dart';
import 'package:time_tracker/app/sign_in/social_sign_in_button.dart';
import 'package:time_tracker/models/user_client.dart';
import 'package:time_tracker/services/auth.dart';

class SignInPage extends StatelessWidget {
  final Function(UserClient?) onSignIn;
  final AuthBase auth;

  const SignInPage({
    Key? key,
    required this.onSignIn,
    required this.auth,
  }) : super(key: key);

  Future<void> _signInAnonymous() async {
    try {
      UserClient? userClient = await auth.signInAnonymously();

      onSignIn(userClient);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text("Time Tracker"),
        elevation: 2.0,
      ),
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Sign In",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 32.0,
            ),
          ),
          SizedBox(
            height: 48.0,
          ),
          SocialSignInButton(
            assetsPath: "assets/images/google-logo.png",
            text: "Sign In With Google",
            backgroundColor: Colors.white,
            textColor: Colors.black,
            onPressed: () {},
          ),
          SizedBox(
            height: 8.0,
          ),
          SocialSignInButton(
            assetsPath: 'assets/images/facebook-logo.png',
            text: "Sign In With Facebook",
            backgroundColor: Colors.blue.shade900,
            textColor: Colors.white,
            onPressed: () {},
          ),
          SizedBox(
            height: 8,
          ),
          SignInButton(
            text: "Sign In With Email",
            backgroundColor: Colors.teal.shade700,
            textColor: Colors.white,
            onPressed: () {},
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            "or",
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 8,
          ),
          SignInButton(
            text: "Go anonyomous",
            backgroundColor: Colors.lime.shade400,
            textColor: Colors.black87,
            onPressed: _signInAnonymous,
          ),
        ],
      ),
    );
  }
}