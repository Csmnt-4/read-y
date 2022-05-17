import 'package:firebase_auth/firebase_auth.dart' as auth;

import '../models/auth_error.dart';
import '../models/firebase_user_entity.dart';

class FirebaseAuthService {
  FirebaseAuthService({
    required auth.FirebaseAuth authService,
  }) : _firebaseAuth = authService;

  final auth.FirebaseAuth _firebaseAuth;

  FirebaseUserEntity _mapFirebaseUser(auth.User? user) {
    if (user == null) {
      return FirebaseUserEntity.empty();
    }

    var splitName = ['Name ', 'LastName'];
    if (user.displayName != null) {
      splitName = user.displayName!.split(' ');
    }

    final map = <String, dynamic>{
      'id': user.uid,
      'firstName': splitName.first,
      'lastName': splitName.last,
      'email': user.email ?? '',
      'emailVerified': user.emailVerified,
      'imageUrl': user.photoURL ?? '',
      'isAnonymous': user.isAnonymous,
      'age': 0,
      'phoneNumber': '',
      'address': '',
    };
    return FirebaseUserEntity.fromJson(map);
  }

  Future<FirebaseUserEntity> signInWithEmailAndPassword({
    required String email,
    required String password,

  }) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return _mapFirebaseUser(userCredential.user!);
    } on auth.FirebaseAuthException catch (e) {
      print(e);
      throw _determineError(e);
    }
  }

  Future<FirebaseUserEntity> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return _mapFirebaseUser(_firebaseAuth.currentUser!);
    } on auth.FirebaseAuthException catch (e) {
      throw _determineError(e);
    }
  }

  AuthError _determineError(auth.FirebaseAuthException exception) {
    switch (exception.code) {
      case 'invalid-email':
        return AuthError.invalidEmail;
      case 'user-disabled':
        return AuthError.userDisabled;
      case 'user-not-found':
        return AuthError.userNotFound;
      case 'wrong-password':
        return AuthError.wrongPassword;
      case 'email-already-in-use':
      case 'account-exists-with-different-credential':
        return AuthError.emailAlreadyInUse;
      case 'invalid-credential':
        return AuthError.invalidCredential;
      case 'operation-not-allowed':
        return AuthError.operationNotAllowed;
      case 'weak-password':
        return AuthError.weakPassword;
      case 'ERROR_MISSING_GOOGLE_AUTH_TOKEN':
      default:
        return AuthError.error;
    }
  }
}