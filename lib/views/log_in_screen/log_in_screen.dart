import 'package:plo/model/types/enum_type.dart';
import 'package:plo/views/forgot_password/forgot_password_screen.dart';
import 'package:plo/views/home_screen/home_screen.dart';
import 'package:plo/views/log_in_screen/log_in_controller.dart';
import 'package:plo/views/log_in_screen/widgets/log_in_textfield.dart';
import 'package:plo/views/settings_screen/settings_screen.dart';
import 'package:plo/views/sign_up_screen_view/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final snackbar = const SnackBar(content: Text("result"));

  @override
  void dispose() {
    super.dispose();
    _formKey.currentState?.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  static const defaultSpacing = SizedBox(height: 10);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("People Link One")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Log-in'),
                const SizedBox(height: 10),
                LogInTextFieldWidget(
                  formKey: _formKey,
                  emailController: emailController,
                  passwordController: passwordController,
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ForgotPasswordScreen(),
                      ),
                    );
                  },
                  child: const Text("Forgot Password?"),
                ),
                TextButton(
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder: (context) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                    if (_formKey.currentState!.validate()) {
                      final result = await ref
                          .watch(loginController.notifier)
                          .loginWithEmail();
                      Navigator.of(context).pop();

                      if (result == ReturnTypeENUM.success.toString()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  // const SettingsScreen()
                                  const HomeScreen(),
                              ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      }
                    } else {
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text("Log-in"),
                ),
                defaultSpacing,
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Text("New User"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpScreen()),
                      );
                    },
                    child: const Text("Sign-Up"),
                  )
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
