import 'package:email_vertify/model/types/enum_type.dart';
import 'package:email_vertify/views/forgot_password/forgot_password_screen.dart';
import 'package:email_vertify/views/home_screen/home_screen.dart';
import 'package:email_vertify/views/log_in_screen/log_in_controller.dart';
import 'package:email_vertify/views/log_in_screen/widgets/log_in_textfield.dart';
import 'package:email_vertify/views/sign_up_screen_view/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// class SignInScreen extends StatelessWidget {
//   const SignInScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: BackButton(
//             color: const Color(0xFF000000),
//             onPressed: () {
//               Navigator.pop(context);
//             }),
//       ),
//       body: const Column(
//         children: [
//           Center(
//             child: Text("Log-in Screen"),
//           )
//         ],
//       ),
//     );
//   }
// }

class signInScreen extends ConsumerStatefulWidget {
  const signInScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<signInScreen> createState() => _signInScreenState();
}

class _signInScreenState extends ConsumerState<signInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final snackbar = SnackBar(content: Text("result"));

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
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Log-in'),
                SizedBox(height: 10),
                LogInTextFieldWidget(
                  formKey: _formKey,
                  emailController: emailController,
                  passwordController: passwordController,
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ForgotPasswordScreen(),
                      ),
                    );
                  },
                  child: Text("Forgot Password?"),
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
                            builder: (context) => const HomeScreen(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      }
                    } else {
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text("Log-in"),
                ),
                defaultSpacing,
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text("New User"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpScreen()),
                      );
                    },
                    child: Text("Sign-Up"),
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
