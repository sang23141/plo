import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plo/common/widgets/custom_app_bar.dart';
import 'package:plo/views/forgot_password/forgot_password_controller.dart';

class forgotPasswordCheckEmailScreen extends ConsumerWidget {
  const forgotPasswordCheckEmailScreen({super.key});

  static const defaultSpacing = SizedBox(height: 10);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: const BackButtonAppBar(),
        body: SafeArea(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              Expanded(child: Container()),
              const Text("Check your Email"),
              defaultSpacing,
              const Text("We sent the reset password to the email"),
              defaultSpacing,
              const Text("Did not receive an Email?"),
              TextButton(
                child: const Text("resend"),
                onPressed: () async {
                  const snackBar =
                      SnackBar(content: Text("failed to send an email"));
                  const snackBar2 = SnackBar(
                    content: Text("we have resent the email"),
                  );
                  final result = await ref
                      .read(forgotPasswordControllerProvider.notifier)
                      .resendResetPasswordEmail();
                  if (!result) {
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    return;
                  }
                  ScaffoldMessenger.of(context).showSnackBar(snackBar2);
                },
              ),
            ])));
  }
}
