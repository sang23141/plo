import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpInfoNotifier
    extends StateNotifier<Map<String, TextEditingController>> {
  SignUpInfoNotifier()
      : super({
          "email": TextEditingController(),
          "password": TextEditingController(),
          "passwordRetype": TextEditingController(),
        });

  void setEmailAndPassword(
      TextEditingController email, TextEditingController password, TextEditingController passwordRetype) {
    state = {
      "email": email,
      "password": password,
      "passwordRetype": passwordRetype,
    };
  }
}

final signUpInfoProvider = StateNotifierProvider<SignUpInfoNotifier,
    Map<String, TextEditingController>>(
  (ref) => SignUpInfoNotifier(),
);
