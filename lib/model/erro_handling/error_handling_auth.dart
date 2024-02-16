import 'package:firebase_auth/firebase_auth.dart';

class ErrorHandlerFunction {
  /// Sign up error handling
  String signupErrorToString(FirebaseAuthException exception) {
    // print("AuthErrorfunction -> code:${exception.code}");
    switch (exception.code) {
      case 'email-already-in-use':
        return "이미 사용중인 이메일입니다.";
      case 'invalid-email':
        return "사용할 수 없는 이메일입니다.";
      case 'weak-password':
        return "비밀번호가 너무 취약합니다 다시 입력 해주세요";
      default:
        return "알 수 없는 firebaseauth 에러가 발생했습니다. 개발자에게 문의 해주세요";
    }
  }

  /// Sign in error hadnling
  String signInErrorToString(FirebaseAuthException exception) {
    // print("AuthErrorfunction -> code:${exception.code}");
    switch (exception.code) {
      case 'user-disabled':
        return "You account has been disabled. Please contact for more information";
      case 'invalid-email':
        return "The email you typed was badly formatted. Please type in valid email address";
      case 'wrong-password':
        return "The password you entered was wrong. Please type in correct password";
      case 'user-not-found':
        return "No user found with the email and password provided. If you are not signed up, please do so";
      default:
        return "Unknown firebaseauth error. Please contact developers";
    }
  }
}
