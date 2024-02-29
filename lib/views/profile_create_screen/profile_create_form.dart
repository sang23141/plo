import 'package:email_vertify/common/validator/validator.dart';
import 'package:email_vertify/repository/auth_repository.dart';
import 'package:email_vertify/views/log_in_screen/log_in_screen.dart';
import 'package:email_vertify/views/profile_create_screen/profile_controller.dart';
import 'package:email_vertify/views/sign_up_screen_view/signup_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:email_vertify/common/widget/my_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';

//프로필 상세 입력 Stateful TextFormField 및 확인 버튼
class ProfileForm extends ConsumerStatefulWidget {
  const ProfileForm({super.key});

  @override
  ConsumerState<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends ConsumerState<ProfileForm> {
  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  final auth = AuthMethods();

  TextEditingController nickname = TextEditingController();
  TextEditingController grade = TextEditingController();
  TextEditingController major = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final signupInfo = ref.watch(signUpInfoProvider);
    final email = signupInfo['email'] ?? '';
    final password = signupInfo['password'] ?? '';
    File? profilePic = ref.watch(selectedFile);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            //정보 입력란 패딩
            padding: const EdgeInsets.only(top: 10.0, left: 50.0, right: 50.0),
            child: Column(
              children: [
                //-----------------------닉네임 입력-----------------------------
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 30.0),
                      child: Text(
                        "닉네임",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Stack(
                      children: [
                        shadowBox(
                          width: 300,
                          height: 55,
                          circularRadius: 9.0,
                          offset: const Offset(0, 1),
                        ),
                        textFormFieldErr(
                          circularRadius: 9.0,
                          controller: nickname,
                          validator: (value) =>
                              Validator.validateNickName(value),
                          textInputAction: TextInputAction.next,
                        ),
                      ],
                    ),
                  ],
                ),

                //-------------------------학년 입력-----------------------------
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 25.0),
                      child: Text(
                        "학년",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Stack(
                      children: [
                        shadowBox(
                          width: 300,
                          height: 55,
                          circularRadius: 9.0,
                          offset: const Offset(0, 1),
                        ),
                        textFormFieldErr(
                          controller: grade,
                          inputType: TextInputType.number,
                          inputRules: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^[1-9][0-9]*'),
                            ),
                            LengthLimitingTextInputFormatter(1),
                          ],
                          circularRadius: 9.0,
                          validator: (value) => Validator.validateGrade(value),
                          textInputAction: TextInputAction.next,
                        ),
                      ],
                    )
                  ],
                ),

                //-------------------------전공 입력-----------------------------
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 25.0),
                      child: Text(
                        "전공",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Stack(
                      children: [
                        shadowBox(
                          width: 300,
                          height: 55,
                          circularRadius: 9.0,
                          offset: const Offset(0, 1),
                        ),
                        textFormFieldErr(
                          circularRadius: 9.0,
                          controller: major,
                          validator: (value) => Validator.validateMajor(value),
                          textInputAction: TextInputAction.done,
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          //확인 버튼
          Padding(
            padding: const EdgeInsets.only(top: 60.0),
            child: Stack(
              children: [
                shadowBox(
                  width: 160,
                  height: 60,
                  circularRadius: 20.0,
                  offset: const Offset(0, 4),
                ),
                SizedBox(
                  width: 160,
                  height: 60,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor: MaterialStateProperty.all(
                        const Color(0xFFCCE7FF),
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        String result = await auth.signUpUser(
                            email: email,
                            password: password,
                            nickname: nickname.text,
                            grade: grade.text,
                            major: major.text,
                            file: profilePic);
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const signInScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      '확인',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
