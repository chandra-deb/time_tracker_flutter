import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:time_tracker/app/sign_in/validators.dart';
import 'package:time_tracker/app/widgets/form_submit_button.dart';
import 'package:time_tracker/app/widgets/platform_alert_dialog.dart';
import 'package:time_tracker/services/auth.dart';

enum SignInFormType { signIn, register }

class EmailSignInForm extends StatefulWidget with EmailAndPasswordValidators {
  final AuthBase auth;
  EmailSignInForm({
    Key? key,
    required this.auth,
  }) : super(key: key);

  @override
  State<EmailSignInForm> createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String get _email => _emailController.text;
  String get _password => _passwordController.text;

  var _formType = SignInFormType.signIn;
  var _submitted = false;
  var _loading = false;

  void _clearInput() {
    _emailController.clear();
    _passwordController.clear();
  }

  Future<void> _sumbit() async {
    setState(() {
      _loading = true;
      _submitted = true;
    });
    FocusManager.instance.primaryFocus!.unfocus();
    try {
      if (_formType == SignInFormType.signIn) {
        await widget.auth.signInWithEmailAndPassword(_email, _password);
      } else {
        await widget.auth.createAccountWithEmailAndPassword(_email, _password);
      }
      Navigator.of(context).pop();
    } on Exception catch (e) {
      print(e.toString());
      PlatformAlertDialog(
        title: "Sign In Failed",
        content: e.toString(),
        defaultActionText: "Ok",
      ).show(context);
      // showDialog(
      //     context: context,
      //     builder: (context) {
      //       if (_formType == SignInFormType.signIn) {
      //         return AlertDialog(
      //           title: Text("Sign In Failed!"),
      //           content: Text(e.toString()),
      //           actions: [
      //             ElevatedButton(
      //               child: Text("Ok"),
      //               onPressed: () => Navigator.of(context).pop(),
      //             ),
      //           ],
      //         );
      //       }
      //       return AlertDialog(
      //         title: Text("Sign Up Failed!"),
      //         content: Text(e.toString()),
      //         actions: [
      //           ElevatedButton(
      //             child: Text("Ok"),
      //             onPressed: () => Navigator.of(context).pop(),
      //           ),
      //         ],
      //       );
      //     });
    } finally {
      setState(() {
        _loading = false;
      });
    }
    // _clearInput();
  }

  void toggleFormType() {
    setState(() {
      _submitted = false;
    });

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

    bool submitEnabled = widget.emailValidator.isValid(_email) &&
        widget.passwordValidator.isValid(_password) &&
        !_loading;

    return [
      _buildEmailField(_emailController),
      SizedBox(height: 8.0),
      _buildPasswordField(_passwordController),
      SizedBox(height: 8.0),
      FormSubmitButton(
        text: primaryText,
        onPressed: submitEnabled ? _sumbit : null,
      ),
      SizedBox(height: 8.0),
      ElevatedButton(
        child: Text(secondaryText),
        onPressed: _loading ? null : toggleFormType,
      ),
    ];
  }

  void _updateState() {
    setState(() {});
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

  Widget _buildEmailField(TextEditingController emailController) {
    bool showErrorText = _submitted && !widget.emailValidator.isValid(_email);
    return TextField(
      controller: emailController,
      onChanged: (_) => _updateState(),
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'test@test.com',
        errorText: showErrorText ? widget.invalidEmailErrorText : null,
      ),
      enabled: _loading == false,
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
    );
  }

  Widget _buildPasswordField(TextEditingController passwordController) {
    bool showErrorText =
        _submitted && !widget.passwordValidator.isValid(_password);

    return TextField(
      controller: passwordController,
      onChanged: (_) => _updateState(),
      decoration: InputDecoration(
        labelText: 'Password',
        errorText: showErrorText ? widget.invalidPasswordErrorText : null,
      ),
      enabled: _loading == false,
      textInputAction: TextInputAction.done,
      obscureText: true,
      onEditingComplete: _sumbit,
    );
  }
}
