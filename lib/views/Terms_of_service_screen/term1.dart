import 'package:email_vertify/common/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class Term1 extends StatelessWidget {
  const Term1({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(),
      body: Text("안녕하세요 이것은 terms of service1 입니다"),
    );
  }
}
