import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:time_tracker/models/user_client.dart';

abstract class AuthBase {
  Stream<UserClient?> get authStateChanges;
  UserClient? currentUser();
  Future<UserClient?> signInAnonymously();
  Future<UserClient?> signInWithGoogle();
  Future<UserClient?> signInWithEmailAndPassword(String email, String password);
  Future<UserClient?> createAccountWithEmailAndPassword(
      String email, String password);

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
  Future<UserClient?> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        final authResult = await _firebaseAuth.signInWithCredential(
          GoogleAuthProvider.credential(
            idToken: googleAuth.idToken,
            accessToken: googleAuth.accessToken,
          ),
        );
        return _userFromFirebase(authResult.user);
      } else {
        throw FirebaseAuthException(
          code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
          message: 'Missing Google Auth Token',
        );
      }
    } else {
      throw FirebaseAuthException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign in aborted by user',
      );
    }
  }

  @override
  Future<UserClient?> signInWithEmailAndPassword(
      String email, String password) async {
    UserCredential userCredential = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
    return _userFromFirebase(userCredential.user);
  }

  @override
  Future<UserClient?> createAccountWithEmailAndPassword(
      String email, String password) async {
    UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    return _userFromFirebase(userCredential.user);
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    final GoogleSignIn googleUser = GoogleSignIn();
    await googleUser.signOut();
  }
}
