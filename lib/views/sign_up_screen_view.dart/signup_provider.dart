import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpInfoNotifier
    extends StateNotifier<Map<String, String?>> {
  SignUpInfoNotifier()
      : super({
          "email": null,
          "password": null,
          "passwordRetype": null,
        });

  void setEmailAndPassword(
      TextEditingController email, TextEditingController password, TextEditingController passwordRetype) {
    state = {
      "email": email.text,
      "password": password.text,
      "passwordRetype": passwordRetype.text,
    };
  }
}

final signUpInfoProvider = StateNotifierProvider<SignUpInfoNotifier,
    Map<String, String?>>(
  (ref) => SignUpInfoNotifier(),
);
