import 'package:email_vertify/views/sign_up_screen_view.dart/signup_provider.dart';
import 'package:email_vertify/services/api_service.dart';
import 'package:email_vertify/vertification_code.dart';
import 'package:email_vertify/common/widget/my_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:email_vertify/common/validator/validator.dart';

class Sign_upScreen extends ConsumerStatefulWidget {
  const Sign_upScreen({super.key});

  @override
  ConsumerState<Sign_upScreen> createState() => _Sign_upScreenState();
}

class _Sign_upScreenState extends ConsumerState<Sign_upScreen> {
  bool invalidEmail = false;
  bool invalidPassword = false;
  bool notSamePassword = false;
  bool isLoading = false;
  bool isPasswordVisible = false;
  TextEditingController password = TextEditingController();
  TextEditingController passwordRetype = TextEditingController();
  TextEditingController email = TextEditingController();

  // @override
  // void initState() {
  //   super.initState();
  //   //Provider wriiten to save state when user goes to next page and come back
  //   ref
  //       .read(signUpInfoProvider.notifier)
  //       .setEmailAndPassword(email, password, passwordRetype);
  // }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    passwordRetype.dispose();
    super.dispose();
  }

  // Function to send verification code to email
  void sendVertCodeToEmail() {
    String? emailError = Validator.validatePSUEmail(email.text);
    String? passwordError = Validator.validatePassword(password.text);
    String? passwordRetypeError =
        Validator.isSamePassword(password.text, passwordRetype.text);

    if (emailError == null &&
        passwordError == null &&
        passwordRetypeError == null) {
      setState(() {
        isLoading = true;
        invalidEmail = false;
        invalidPassword = false;
        notSamePassword = false;
      });

      //Pass email and password to signup_provider
      ref
          .watch(signUpInfoProvider.notifier)
          .setEmailAndPassword(email, password, passwordRetype);

      // Make API call to get OTP
      EmailAPIService.otpLogin(email.text).then((response) {
        setState(() {
          isLoading = false; // Hide loading indicator
        });

        // If response contains data, navigate to VertCodeScreen
        if (response.data != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) => VertCodeScreen(
                    emailcontroller: email,
                    otpHash: response.data!,
                  )),
            ),
          );
        }
      });
    } else {
      //Three must be declared as false at the begining else it will continously show the error message even though the error is gone.
      setState(() {
        isLoading = false;
        invalidEmail = false;
        invalidPassword = false;
        notSamePassword = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.center,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            //나중에 plo로고로 대체해야 합니다.
            const Icon(
              Icons.person,
              size: 80,
            ),

            const Text(
              '회원가입',
              style: TextStyle(fontSize: 24),
            ),

            const SizedBox(height: 20),

            TextInputBox(
              text: '학교 이메일',
              boxWidth: 331,
              boxHeight: 40,
              textController: email,
              wrongInput: invalidEmail,
              errorMessage: "학교 이메일이 아니거나 존재하지 않는 이메일 입니다",
            ),

            const SizedBox(height: 20),

            passwordInputBox(
              text: '비밀번호',
              boxWidth: 331,
              boxHeight: 40,
              textController: password,
              passwordVisible: isPasswordVisible,
              onPressed: () => setState(() {
                isPasswordVisible = !isPasswordVisible;
              }),
              wrongInput: invalidPassword,
              errorMessage:
                  "비밀번호 조건에 부합하지 않습니다\n\n다음 요건을 충족해 주세요\n- 8자 이상\n- 숫자 1개 이상\n- 소문자 1개 이상\n- 대문자 1개 이상\n- 특수문자 1개 이상",
            ),

            const SizedBox(height: 20),
            passwordInputBox(
              text: '비밀번호 확인',
              boxWidth: 331,
              boxHeight: 40,
              textController: passwordRetype,
              passwordVisible: isPasswordVisible,
              onPressed: () => setState(() {
                isPasswordVisible = !isPasswordVisible;
              }),
              wrongInput: notSamePassword,
              errorMessage: "비밀번호가 일치하지 않습니다",
            ),

            const SizedBox(height: 90),
            isLoading
                ? const CircularProgressIndicator()
                : ButtonBox(
                    text: '인증번호 보내기',
                    boxWidth: 180,
                    boxHeight: 60,
                    buttonFunc: sendVertCodeToEmail),

            const SizedBox(height: 30),
          ]),
        ),
      ),
    );
  }
}
