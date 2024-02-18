import 'package:email_vertify/common/validator/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:email_vertify/common/widget/my_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//프로필 상세 입력 Stateful TextFormField 및 확인 버튼
class ProfileForm extends StatefulWidget {
  const ProfileForm({super.key});

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}


class _ProfileFormState extends State<ProfileForm> {
  final _formKey = GlobalKey<FormState>();

  

  TextEditingController nickname = TextEditingController();
  TextEditingController grade = TextEditingController();
  TextEditingController major = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                          validator: (value) =>Validator.validateNickName(value),
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
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                       
                        print("hell o");
                       
                      }
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
