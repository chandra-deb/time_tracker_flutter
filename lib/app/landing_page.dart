import 'package:flutter/material.dart';

import 'package:time_tracker/app/home_page.dart';
import 'package:time_tracker/app/sign_in/sign_in_page.dart';
import 'package:time_tracker/models/user_client.dart';
import 'package:time_tracker/services/auth.dart';

class LandingPage extends StatefulWidget {
  final AuthBase auth;

  const LandingPage({
    required this.auth,
    Key? key,
  }) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  UserClient? _user;

  void _updateUser(UserClient? user) {
    setState(() {
      _user = user;
    });
  }

  @override
  void initState() {
    UserClient? user = widget.auth.currentUser();
    _updateUser(user);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return SignInPage(
        auth: widget.auth,
        onSignIn: _updateUser,
      );
    }
    return HomePage(
      auth: widget.auth,
      onSignOut: () => _updateUser(null),
    );
  }
}
