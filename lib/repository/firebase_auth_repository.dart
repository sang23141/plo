import 'package:email_vertify/model/erro_handling/error_handling_auth.dart';
import 'package:email_vertify/model/types/enum_type.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthRepositor {
  static const repoName = 'FirebaseAuthRepository';
  final FirebaseAuth firebase = FirebaseAuth.instance;
  User? getCurrentUser() {
    return firebase.currentUser;
  }

  //sign-up User
  Future<String> signupUser(String email, String password) async {
    try {
      await firebase.createUserWithEmailAndPassword(email: email, password: password);
      return ReturnTypeENUM.success.toString();
    }
    // case of auth error
    on FirebaseAuthException catch (error) {
      String errorText = ErrorHandlerFunction().signupErrorToString(error);
      return errorText;
    }

    //case of general error

    catch (error) {
      print("Error${error.toString()} in signupUser() in $repoName");
      return error.toString();
    }
  }

}