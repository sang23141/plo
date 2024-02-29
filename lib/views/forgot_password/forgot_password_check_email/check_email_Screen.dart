import 'package:email_vertify/views/forgot_password/forgot_password_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class forgotPasswordCheckEmailScreen extends ConsumerWidget {
  const forgotPasswordCheckEmailScreen({super.key});

  static const defaultSpacing = SizedBox(height: 10);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: BackButton(
            color: const Color(0xFF000000),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
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
                child: Text("resend"),
                onPressed: () async {
                  final snackBar =
                      SnackBar(content: Text("failed to send an email"));
                  final snackBar2 = SnackBar(
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
