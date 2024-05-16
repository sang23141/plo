import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plo/model/check_requirements/check_email_usermodel_screen.dart';
import 'package:plo/model/check_requirements/check_requirement_screen.dart';
import 'package:plo/views/settings_screen/provider/non_login_provider.dart';
import 'package:plo/views/sign_up_screen_view/sign_up_screen.dart';

final reloadMainScreenProvider = StateProvider<bool>((ref) => false);

class AuthRequirementScreen extends ConsumerStatefulWidget {
  const AuthRequirementScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AuthRequirementScreenState();
}

class _AuthRequirementScreenState extends ConsumerState<AuthRequirementScreen> {
  @override
  Widget build(BuildContext context) {
    final reloadMainScreen = ref.watch(reloadMainScreenProvider);
    final proceedWithoutLogin = ref.watch(proceedWithoutLoginProvider);
    print("Relaoding Main Screen ${reloadMainScreen}");
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(
                child: const CircularProgressIndicator(),
              ),
            );
          } else if (proceedWithoutLogin) {
            return const CheckAppRequirementsScreen();
          } else if (snapshot.hasData) {
            return const CheckEmailUserModelScreen();
          } else if (snapshot.hasError) {
            return const Scaffold(
                body: Center(
              child: Text("Error has occured"),
            ));
          } else {
            return const SignUpScreen();
          }
        });
  }
}
