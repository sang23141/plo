import 'package:flutter/material.dart';
import 'package:plo/common/widgets/custom_app_bar.dart';

class Term2 extends StatelessWidget {
  const Term2({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: BackButtonAppBar(),
      body: Text("안녕하세요 이것은 terms of service2 입니다"),
    );
  }
}
