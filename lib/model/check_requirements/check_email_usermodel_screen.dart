import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plo/model/check_requirements/check_requirement_screen.dart';
import 'package:plo/repository/firebase_auth_repository.dart';
import 'package:plo/repository/firebase_user_repository.dart';
import 'package:plo/views/sign_up_screen_view/sign_up_screen.dart';

// final isEmailVerifiedProvider = StateProvider.autoDispose<bool>((ref) => FirebaseAuth.instance.currentUser!.emailVerified);
final isUserModelSetUpProvider = FutureProvider.autoDispose((ref) async {
  final user = await ref.watch(firebaseUserRepository).fetchUser();
  if (user == null) {
    return false;
  } else {
    return true;
  }
});

class CheckEmailUserModelScreen extends ConsumerStatefulWidget {
  const CheckEmailUserModelScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CheckEmailUserModelScrenState();
}

class _CheckEmailUserModelScrenState
    extends ConsumerState<CheckEmailUserModelScreen> {
  @override
  Widget build(BuildContext context) {
    // final isEmailVerified = ref.watch(isEmailVerifiedProvider);
    final isUserModelSetUp = ref.watch(isUserModelSetUpProvider);
    // if(isEmailVerified == false)
    return isUserModelSetUp.when(
      error: (error, stackTrace) => Scaffold(
          body: Center(
              child: Text(
        "Unknown error occured. Please try again Later",
      ))),
      loading: () => Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      data: (data) {
        return data == false ? SignUpScreen() : const CheckAppRequirementsScreen();
      }
    );
  }
}
