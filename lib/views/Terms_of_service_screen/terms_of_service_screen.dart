import 'package:email_vertify/common/widgets/custom_app_bar.dart';
import 'package:email_vertify/common/widgets/my_widgets.dart';
import 'package:email_vertify/views/Terms_of_service_screen/term1.dart';
import 'package:email_vertify/views/Terms_of_service_screen/term2.dart';
import 'package:email_vertify/views/Terms_of_service_screen/term3.dart';
import 'package:email_vertify/views/Terms_of_service_screen/terms_provider.dart';
import 'package:email_vertify/views/profile_create_screen/profile_create.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TermsOfServiceScreen extends ConsumerStatefulWidget {
  const TermsOfServiceScreen({super.key});

  @override
  ConsumerState<TermsOfServiceScreen> createState() =>
      _TermsOfServiceScreenState();
}

class _TermsOfServiceScreenState extends ConsumerState<TermsOfServiceScreen> {
  bool? _allIsChecked = false;
  bool? _firstIsChecked = false;
  bool? _secondIsChecked = false;
  bool? _thridIsChecked = false;

  void validateCheckBox() {
    if (_allIsChecked! || (_firstIsChecked! && _secondIsChecked!)) {
      //다음페이지
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ProfileCreate(),
          ));
    } else {
      ref
          .watch(termsInfoProvider.notifier)
          .setCheckBoxes(_firstIsChecked, _secondIsChecked, _thridIsChecked);
    }
  }

  void checkAll() {
    _firstIsChecked = true;
    _secondIsChecked = true;
    _thridIsChecked = true;
  }

  void uncheckAll() {
    _firstIsChecked = false;
    _secondIsChecked = false;
    _thridIsChecked = false;
  }

  @override
  Widget build(BuildContext context) {
    final termInfo = ref.watch(termsInfoProvider);

    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              //나중에 plo로고로 대체해야 합니다.
              const Icon(
                Icons.person,
                size: 80,
              ),
              const Text(
                '약관동의',
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 50),
              Row(
                children: [
                  Transform.scale(
                    scale: 2,
                    child: Checkbox(
                      value: _allIsChecked,
                      checkColor: Colors.black,
                      activeColor: const Color.fromARGB(255, 204, 231, 255),
                      onChanged: (value) {
                        setState(() {
                          _allIsChecked = value;
                          if (_allIsChecked!) {
                            checkAll();
                          } else {
                            uncheckAll();
                          }
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Text("약관 전체동의",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold))
                ],
              ),
              const SizedBox(height: 20),
              Container(
                height: 1.0,
                color: Colors.black,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Transform.scale(
                    scale: 2,
                    child: Checkbox(
                      value: _firstIsChecked,
                      checkColor: Colors.black,
                      activeColor: const Color.fromARGB(255, 204, 231, 255),
                      onChanged: (value) {
                        setState(() {
                          _firstIsChecked = value;
                          if (_allIsChecked! && _firstIsChecked == false) {
                            _allIsChecked = false;
                          }
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Term1(),
                            ));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("어쩌고 저쩌고 동의1",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 75, 74, 74))),
                          Text("(필수)",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: termInfo['checkbox1']!
                                      ? const Color.fromARGB(255, 75, 74, 74)
                                      : Colors.red)),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 28,
                            color: Color.fromARGB(255, 75, 74, 74),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Transform.scale(
                    scale: 2,
                    child: Checkbox(
                      value: _secondIsChecked,
                      checkColor: Colors.black,
                      activeColor: const Color.fromARGB(255, 204, 231, 255),
                      onChanged: (value) {
                        setState(() {
                          _secondIsChecked = value;
                          if (_allIsChecked! && _secondIsChecked == false) {
                            _allIsChecked = false;
                          }
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Term2(),
                            ));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("어쩌고 저쩌고 동의2",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 75, 74, 74))),
                          Text("(필수)",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: termInfo["checkbox2"]!
                                      ? const Color.fromARGB(255, 75, 74, 74)
                                      : Colors.red)),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 28,
                            color: Color.fromARGB(255, 75, 74, 74),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Transform.scale(
                    scale: 2,
                    child: Checkbox(
                      value: _thridIsChecked,
                      checkColor: Colors.black,
                      activeColor: const Color.fromARGB(255, 204, 231, 255),
                      onChanged: (value) {
                        setState(() {
                          _thridIsChecked = value;
                          if (_allIsChecked! && _thridIsChecked == false) {
                            _allIsChecked = false;
                          }
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Term3(),
                            ));
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("어쩌고 저쩌고 동의3",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 75, 74, 74))),
                          Text("(선택)",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 75, 74, 74))),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 28,
                            color: Color.fromARGB(255, 75, 74, 74),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              ButtonBox(
                  text: "다음",
                  boxHeight: 60,
                  boxWidth: 160,
                  buttonFunc: validateCheckBox)
            ]),
          ),
        ),
      ),
    );
  }
}
