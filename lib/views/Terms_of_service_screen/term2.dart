import 'package:email_vertify/common/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class Term2 extends StatelessWidget {
  const Term2({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(),
      body: Text("안녕하세요 이것은 terms of service2 입니다"),
    );
  }
}
