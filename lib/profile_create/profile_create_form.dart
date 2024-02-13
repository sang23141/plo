import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:email_vertify/widget/my_widgets.dart';

//프로필 상세 입력 Stateful TextFormField 및 확인 버튼
class ProfileForm extends StatefulWidget {
  const ProfileForm({super.key});

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final _formKey = GlobalKey<FormState>();
  String nickname = "";
  int grade = 0;
  String major = "";

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
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return "닉네임을 입력해주세요";
                            }
                            return null;
                            /*
                            text == null | text.isEmpty
                                ? "닉네임을 입력해주세요"
                                : (nameExists(text) ? "이미 존재하는 닉네임입니다" : null),
                            */
                          },
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
                          inputType: TextInputType.number,
                          inputRules: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^[1-9][0-9]*'),
                            ),
                            LengthLimitingTextInputFormatter(1),
                          ],
                          circularRadius: 9.0,
                          validator: (text) {
                            //아무 값도 입력하지 않았을 시
                            if (text == null || text.isEmpty) {
                              return "학년을 입력해주세요";
                            }
                            var tempGrade = int.parse(text);
                            grade = tempGrade;
                            return null;
                          },
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
                          validator: (text) {
                            //아무 값도 입력하지 않았을 시
                            if (text == null || text.isEmpty) {
                              return "전공을 입력해주세요";
                            }
                            //올바르지 않은 값 입력 시
                            //...
                            major = text;
                            return null;
                          },
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
                        /*
                        profileSubmit(
                          "test_email@psu.edu",
                          nickname,
                          grade,
                          major,
                        );
                        */
                        print("helo");
                        //다음 페이지로
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
