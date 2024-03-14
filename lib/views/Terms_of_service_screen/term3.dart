import 'package:flutter/material.dart';
import 'package:plo/common/widgets/custom_app_bar.dart';

class Term3 extends StatelessWidget {
  const Term3({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: BackButtonAppBar(),
      body: Text("안녕하세요 이것은 terms of service3 입니다"),
    );
  }
}
