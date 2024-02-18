import 'package:email_vertify/model/types/enum_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:email_vertify/repository/firebase_auth_repository.dart';

class SignUpUserController extends StateNotifier<AsyncValue<void>> {
  final Ref ref;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordRetypeController = TextEditingController();
  SignUpUserController(this.ref) : super(const AsyncValue.data(null));

  TextEditingController get emailController =>  _emailController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get passwordRetypeController => _passwordRetypeController;

  Future<bool> signupUser({required GlobalKey <FormState> formkey} ) async {
    if(formkey.currentState!.validate()) {
      final resultString = await ref.watch(firebaseAuthRepositoryProvider).signupUser(_emailController.text, passwordController.text);
      if (resultString != ReturnTypeENUM.success.toString() ) {
        state = AsyncValue.error(resultString, StackTrace.current);
        return false;
      }
      return true;
    }
    return false;
  }
}

final signupUserControllerProvider = StateNotifierProvider.autoDispose<SignUpUserController, AsyncValue<void>>((ref) {
  return SignUpUserController(ref);
});