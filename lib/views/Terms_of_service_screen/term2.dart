import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Term2 extends StatelessWidget {
  const Term2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color: const Color(0xFF000000),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: const Text("안녕하세요 이것은 terms of service2 입니다"),
    );
  }
}
