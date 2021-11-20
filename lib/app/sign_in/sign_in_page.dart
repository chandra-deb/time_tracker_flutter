import 'package:flutter/material.dart';
import 'package:time_tracker/app/sign_in/email_sign_in_page.dart';

import 'package:time_tracker/app/sign_in/sign_in_button.dart';
import 'package:time_tracker/app/sign_in/social_sign_in_button.dart';
import 'package:time_tracker/app/utils/show_snack_bar.dart';
import 'package:time_tracker/services/auth.dart';

class SignInPage extends StatefulWidget {
  final AuthBase auth;

  const SignInPage({
    Key? key,
    required this.auth,
  }) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool loading = false;

  void startLoading(bool isLoading) {
    setState(() {
      loading = isLoading;
    });
  }

  Future<void> _signInAnonymous() async {
    startLoading(true);
    try {
      await widget.auth.signInAnonymously();
    } catch (e) {
      showSnackBar(context: context, text: e.toString());
      print(e.toString());
      startLoading(false);
    }
  }

  Future<void> _signInWithGoogle() async {
    startLoading(true);
    try {
      await widget.auth.signInWithGoogle();
    } catch (e) {
      showSnackBar(context: context, text: e.toString());
      print(e.toString());
      startLoading(false);
    }
  }

  _signInWithEmail() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (context) => EmailSignInPage(
          auth: widget.auth,
        ),
      ),
    );
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
            onPressed: _signInWithGoogle,
          ),
          SizedBox(
            height: 8.0,
          ),
          SizedBox(
            height: 8,
          ),
          SignInButton(
            text: "Sign In With Email",
            backgroundColor: Colors.teal.shade700,
            textColor: Colors.white,
            onPressed: _signInWithEmail,
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
          SizedBox(height: 10),
          loading == true
              ? Center(child: CircularProgressIndicator())
              : SizedBox(
                  height: 36,
                ),
        ],
      ),
    );
  }
}
