import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

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
            }),
      ),
      body: const Column(
        children: [
          Center(
            child: Text("Log-in Screen"),
          )
        ],
      ),
    );
  }
}
