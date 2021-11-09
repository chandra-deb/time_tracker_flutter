import 'package:firebase_auth/firebase_auth.dart';
import 'package:time_tracker/models/user_client.dart';

abstract class AuthBase {
  Stream<UserClient?> get authStateChanges;
  UserClient? currentUser();
  Future<UserClient?> signInAnonymously();
  Future<void> signOut();
}

class Auth implements AuthBase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  UserClient? _userFromFirebase(User? user) {
    if (user == null) {
      return null;
    }
    return UserClient(uid: user.uid);
  }

  @override
  Stream<UserClient?> get authStateChanges {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  @override
  UserClient? currentUser() {
    var user = _firebaseAuth.currentUser;
    return _userFromFirebase(user);
  }

  @override
  Future<UserClient?> signInAnonymously() async {
    final authResult = await _firebaseAuth.signInAnonymously();
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
