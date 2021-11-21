import 'package:flutter/widgets.dart';
import 'package:time_tracker/services/auth.dart';

class AuthProvider extends InheritedWidget {
  final AuthBase auth;

  const AuthProvider({
    required this.auth,
    required Widget child,
    Key? key,
  }) : super(
          child: child,
          key: key,
        );

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;

  static AuthBase of(BuildContext context) {
    AuthProvider provider = context
        .dependOnInheritedWidgetOfExactType<AuthProvider>() as AuthProvider;
    return provider.auth;
  }
}
