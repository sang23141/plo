import 'package:email_vertify/common/validator/validator.dart';
import 'package:email_vertify/common/widgets/custom_app_bar.dart';
import 'package:email_vertify/common/widgets/my_widgets.dart';
import 'package:email_vertify/views/settings_screen/provider/user_provider.dart';
import 'package:email_vertify/views/settings_screen/settings_controller.dart';
import 'package:email_vertify/views/settings_screen/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileModifyScreen extends ConsumerStatefulWidget {
  const ProfileModifyScreen({super.key});

  @override
  ConsumerState<ProfileModifyScreen> createState() =>
      _ProfileModifyScreenState();
}

class _ProfileModifyScreenState extends ConsumerState<ProfileModifyScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final TextEditingController _nickname = TextEditingController();
  final TextEditingController _grade = TextEditingController();
  final TextEditingController _major = TextEditingController();

  @override
  void dispose() {
    _nickname.dispose();
    _grade.dispose();
    _major.dispose();
    super.dispose();
  }

  static const SizedBox defaultSpacing = SizedBox(height: 20);
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userInfoProvider);
    _grade.text = user.grade;
    _nickname.text = user.nickname;
    _major.text = user.major;

    return Scaffold(
      appBar: const CustomAppBar(title: "프로필 수정"),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                textInputBox(
                    text: "닉네임",
                    controller: _nickname,
                    validator: (value) => Validator.validateNickName(value)),
                defaultSpacing,
                textInputBox(
                    text: "학년",
                    controller: _grade,
                    validator: (value) => Validator.validateGrade(value)),
                defaultSpacing,
                textInputBox(
                    text: "전공",
                    controller: _major,
                    validator: (value) => Validator.validateMajor(value)),
                const SizedBox(height: 50),
                _isLoading
                    ? const CircularProgressIndicator()
                    : ButtonBox(
                        text: '변경사항 저장',
                        boxWidth: 190,
                        boxHeight: 60,
                        buttonFunc: () {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              _isLoading = true;
                            });
                            updateEditedUserdataToFirestore(
                                _grade.text, _major.text, _nickname.text);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) =>
                                      const SettingsScreen()),
                                ));
                            setState(() {
                              _isLoading = false;
                            });
                          }
                        }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
