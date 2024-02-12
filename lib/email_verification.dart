import 'package:email_vertify/providers/signup_provider.dart';
import 'package:email_vertify/services/api_service.dart';
import 'package:email_vertify/vertification_code.dart';
import 'package:email_vertify/widget/my_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmailVerificationScreen extends ConsumerStatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  ConsumerState<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState
    extends ConsumerState<EmailVerificationScreen> {
  bool invalidEmail = false;
  bool invalidPassword = false;
  bool notSamePassword = false;
  bool isLoading = false;
  bool isPasswordVisible = false;
  TextEditingController password = TextEditingController();
  TextEditingController passwordRetype = TextEditingController();
  TextEditingController email = TextEditingController();

  @override
  void initState() {
    super.initState();
    //Provider wriiten to save state when user goes to next page and come back
    final signUpInfo = ref.read(signUpInfoProvider);
    email = signUpInfo["email"]!;
    password = signUpInfo["password"]!;
    passwordRetype = signUpInfo["passwordRetype"]!;
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    passwordRetype.dispose();
    super.dispose();
  }

  // Function to validate PSU email format
  bool validatePSUEmail(String email) {
    RegExp regExp = RegExp(r'[a-z]{3}[0-9]{1,4}@psu.edu');
    return regExp.hasMatch(email);
  }

  bool validatePassword(String password) {
    RegExp regExp = RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$');
    return regExp.hasMatch(password);
  }

  bool isSamePassword(String password, String passwordRetype) {
    if (passwordRetype.isEmpty) {
      return false;
    }

    return password == passwordRetype;
  }

  // Function to send verification code to email
  void sendVertCodeToEmail() {
    if (isSamePassword(password.text, passwordRetype.text) &&
        validatePSUEmail(email.text) &&
        validatePassword(password.text)) {
      setState(() {
        isLoading = true; // Show loading indicator
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
      invalidEmail = false;
      invalidPassword = false;
      notSamePassword = false;
      if (validatePSUEmail(email.text) == false) {
        setState(() {
          invalidEmail = true;
        });
      }
      if (validatePassword(password.text) == false) {
        setState(() {
          invalidPassword = true;
        });
      }

      if (isSamePassword(password.text, passwordRetype.text) == false) {
        setState(() {
          notSamePassword = true;
        });
      }
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
