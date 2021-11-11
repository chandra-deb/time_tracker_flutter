import 'package:flutter/material.dart';
import 'package:time_tracker/app/widgets/form_submit_button.dart';

enum SignInFormType { signIn, register }

class EmailSignInForm extends StatefulWidget {
  const EmailSignInForm({Key? key}) : super(key: key);

  @override
  State<EmailSignInForm> createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  var _formType = SignInFormType.signIn;

  void _clearInput() {
    _emailController.clear();
    _passwordController.clear();
  }

  _sumbit() {
    print(_emailController.text);
    print(_passwordController.text);
    _clearInput();
  }

  void toggleFormType() {
    print("Toggle Form Type Called");
    setState(() {
      _formType = _formType == SignInFormType.register
          ? SignInFormType.signIn
          : SignInFormType.register;
    });
    _clearInput();
  }

  List<Widget> _buildChildren() {
    String primaryText =
        _formType == SignInFormType.signIn ? "Sign In" : "Create Account";
    String secondaryText = _formType == SignInFormType.signIn
        ? "Don't have a account? Create one"
        : "Already have a account? Sign In";

    return [
      TextField(
        controller: _emailController,
        decoration: InputDecoration(
          labelText: 'Email',
          hintText: 'test@test.com',
        ),
      ),
      SizedBox(height: 8.0),
      TextField(
        controller: _passwordController,
        decoration: InputDecoration(
          labelText: 'Password',
        ),
        obscureText: true,
      ),
      SizedBox(height: 8.0),
      FormSubmitButton(
        text: primaryText,
        onPressed: _sumbit,
      ),
      SizedBox(height: 8.0),
      ElevatedButton(
        child: Text(secondaryText),
        onPressed: toggleFormType,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: _buildChildren(),
      ),
    );
  }
}
