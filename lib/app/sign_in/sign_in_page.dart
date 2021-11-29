import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/app/sign_in/email_sign_in_page.dart';

import 'package:time_tracker/app/sign_in/sign_in_button.dart';
import 'package:time_tracker/app/sign_in/social_sign_in_button.dart';
import 'package:time_tracker/app/widgets/firebase_exception_alert_dialog.dart';
import 'package:time_tracker/app/widgets/platform_exception_alert.dart';
import 'package:time_tracker/services/auth.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({
    Key? key,
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

  void _showSignInError(BuildContext context, FirebaseAuthException exception) {
    print(exception.code);
    FirebaseExceptionDialog(
      title: "Sign In Failed!",
      exception: exception,
    ).show(context);
  }

  Future<void> _signInAnonymous() async {
    startLoading(true);
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);

      await auth.signInAnonymously();
    } on FirebaseAuthException catch (e) {
      _showSignInError(context, e);
    } finally {
      startLoading(false);
    }
  }

  Future<void> _signInWithGoogle() async {
    startLoading(true);
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);

      await auth.signInWithGoogle();
    } on FirebaseAuthException catch (e) {
      // showSnackBar(context: context, text: e.toString());
      if (e.code != "ERROR_ABORTED_BY_USER") {
        _showSignInError(context, e);
      }
    } on PlatformException catch (e) {
      print(e.code);
      PlatformExceptionAlertDialog(
        exception: e,
        title: "Sign In Failed!",
      ).show(context);
    } finally {
      startLoading(false);
    }
  }

  _signInWithEmail() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (context) => EmailSignInPage(),
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
          SizedBox(height: 50, child: _buildHeader()),
          SizedBox(
            height: 48.0,
          ),
          SocialSignInButton(
            assetsPath: "assets/images/google-logo.png",
            text: "Sign In With Google",
            backgroundColor: Colors.white,
            textColor: Colors.black,
            onPressed: loading ? null : _signInWithGoogle,
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
            onPressed: loading ? null : _signInWithEmail,
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
            onPressed: loading ? null : _signInAnonymous,
          ),
          // SizedBox(height: 10),
          // loading == true
          //     ? Center(child: CircularProgressIndicator())
          //     : SizedBox(
          //         height: 36,
          //       ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return loading == true
        ? Center(child: CircularProgressIndicator())
        : Text(
            "Sign In",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 32.0,
            ),
          );
  }
}
