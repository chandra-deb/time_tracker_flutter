import 'dart:async';
import 'package:time_tracker/models/user_client.dart';
import 'package:time_tracker/services/auth.dart';

class SignInBloc {
  final _loadingController = StreamController<bool>();
  final AuthBase auth;

  SignInBloc({required this.auth});

  Stream<bool> get isLoadingStream => _loadingController.stream;

  void _setIsLoading(bool isLoading) => _loadingController.add(isLoading);

  Future<UserClient?> _signIn(
      Future<UserClient?> Function() signInMethod) async {
    try {
      _setIsLoading(true);
      return await signInMethod();
    } catch (e) {
      _setIsLoading(false);
      rethrow;
    }
  }

  Future<UserClient?> signInAnonymously() => _signIn(auth.signInAnonymously);
  Future<UserClient?> signInWithGoogle() => _signIn(auth.signInWithGoogle);

  void dispose() {
    _loadingController.close();
  }
}
