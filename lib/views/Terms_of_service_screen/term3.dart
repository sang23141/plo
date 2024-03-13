import 'package:email_vertify/common/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class Term3 extends StatelessWidget {
  const Term3({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(),
      body: Text("안녕하세요 이것은 terms of service3 입니다"),
    );
  }
}
