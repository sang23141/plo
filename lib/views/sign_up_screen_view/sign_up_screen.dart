import 'package:email_vertify/common/validator/validator.dart';
import 'package:email_vertify/common/widgets/custom_app_bar.dart';
import 'package:email_vertify/common/widgets/my_widgets.dart';
import 'package:email_vertify/services/api_service.dart';
import 'package:email_vertify/vertification_code.dart';
import 'package:email_vertify/views/sign_up_screen_view/provider/signup_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _isPasswordVisible = false;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _passwordRetype = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _passwordRetype.dispose();
    super.dispose();
  }

  //Pass email and password to signup_provider
  void _setProvider() {
    ref
        .watch(signUpInfoProvider.notifier)
        .setEmailAndPassword(_email, _password, _passwordRetype);
  }

  // Function to send verification code to email
  void sendVertCodeToEmail() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      _setProvider();

      //Make API call to get OTP
      EmailAPIService.otpLogin(_email.text).then((response) {
        //If API response contains data, navigate to VertCodeScreen
        if (response.data != null) {
          setState(() {
            _isLoading = false; // Hide loading indicator
          });

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) => VertCodeScreen(
                    emailcontroller: _email,
                    otpHash: response.data!,
                  )),
            ),
          );
        }
      });
    }
  }

  static const SizedBox defaultSpacing = SizedBox(height: 20);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
            child: Form(
              key: _formKey,
              child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //나중에 plo로고로 대체해야 합니다.
                      const Icon(
                        Icons.person,
                        size: 80,
                      ),

                      const Text(
                        '회원가입',
                        style: TextStyle(fontSize: 24),
                      ),

                      defaultSpacing,

                      textInputBox(
                          text: '학교 이메일',
                          controller: _email,
                          validator: (value) =>
                              Validator.validatePSUEmail(value)),

                      defaultSpacing,

                      passwordInputBox(
                        text: '비밀번호',
                        controller: _password,
                        passwordVisible: _isPasswordVisible,
                        onPressed: () => setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        }),
                        validator: (value) => Validator.validatePassword(value),
                      ),

                      defaultSpacing,

                      passwordInputBox(
                        text: '비밀번호 확인',
                        controller: _passwordRetype,
                        passwordVisible: _isPasswordVisible,
                        onPressed: () => setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        }),
                        validator: (value) =>
                            Validator.isSamePassword(value, _password.text),
                      ),

                      const SizedBox(height: 90),
                      _isLoading
                          ? const CircularProgressIndicator()
                          : ButtonBox(
                              text: '인증번호 보내기',
                              boxWidth: 190,
                              boxHeight: 60,
                              buttonFunc: sendVertCodeToEmail),

                      const SizedBox(height: 30),
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
