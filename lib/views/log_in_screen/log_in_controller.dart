import 'package:email_vertify/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginWithEmailController extends StateNotifier<AsyncValue<void>> {
  final Ref ref;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  LoginWithEmailController(this.ref) : super(const AsyncValue.data(null));

  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;

  Future<String> loginWithEmail() async {
    final result = await ref
        .watch(authRepository)
        .signiInUserWithEmail(_emailController.text, _passwordController.text);
    return result;
  }
}

final loginController = StateNotifierProvider.autoDispose<
    LoginWithEmailController,
    AsyncValue<void>>((ref) => LoginWithEmailController(ref));