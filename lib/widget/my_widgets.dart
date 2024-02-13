import 'package:flutter/material.dart';

Color PLOShadowColor = const Color.fromARGB(200, 0, 0, 0);

Widget NumInputBox(BuildContext context, TextEditingController textController,
    {bool? wrongInput = false}) {
  return Material(
    elevation: 5,
    shadowColor: PLOShadowColor,
    child: Container(
      height: 85,
      width: 73,
      decoration: BoxDecoration(
        border: Border.all(
            width: 1, color: wrongInput! ? Colors.red : Colors.black),
      ),
      child: TextField(
        controller: textController,
        maxLength: 1,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        style: const TextStyle(fontSize: 50),
        decoration: const InputDecoration(counterText: ''),
        showCursor: false,
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
          if (value.isEmpty) {
            FocusScope.of(context).previousFocus();
          }
        },
        onTap: () => FocusScope.of(context),
      ),
    ),
  );
}

// commentation needed
Widget TextInputBox(
    {required String text,
    double? boxWidth = 200,
    double? boxHeight = 50,
    double? fontSize = 20,
    required TextEditingController textController,
    bool? wrongInput = false,
    String errorMessage = ""}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        text,
        style: const TextStyle(fontSize: 20),
      ),
      Material(
        shadowColor: PLOShadowColor,
        elevation: 5,
        child: Container(
          width: boxWidth,
          height: boxHeight,
          decoration: BoxDecoration(
            border: Border.all(
                width: 1, color: wrongInput! ? Colors.red : Colors.black),
            borderRadius: BorderRadius.circular(6),
          ),
          child: TextField(
            controller: textController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(fontSize: fontSize),
          ),
        ),
      ),
      Text(
        wrongInput ? errorMessage : '',
        style: const TextStyle(color: Colors.red, fontSize: 12),
      )
    ],
  );
}

Container ButtonBox(
    {required String text,
    Color? color = const Color.fromARGB(255, 204, 231, 255),
    double? boxWidth = 200,
    double? boxHeight = 50,
    Function()? buttonFunc,
    bool? wrongInput = false}) {
  return Container(
    height: boxHeight,
    width: boxWidth,
    child: OutlinedButton(
      onPressed: buttonFunc,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        side: const BorderSide(color: Colors.transparent),
        backgroundColor: color,
        shadowColor: PLOShadowColor,
        elevation: 5,
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.black,
        ),
      ),
    ),
  );
}

Widget alertInputBox(
    {required BuildContext context,
    required String title,
    required String content}) {
  return AlertDialog(
    title: Text(title),
    content: Text(content),
    actions: <Widget>[
      TextButton(
        onPressed: () => Navigator.pop(context, 'Cancel'),
        child: const Text('Cancel'),
      ),
      TextButton(
        onPressed: () => Navigator.pop(context, 'OK'),
        child: const Text('OK'),
      ),
    ],
  );
}

Widget passwordInputBox(
    {required String text,
    double? boxWidth = 200,
    double? boxHeight = 50,
    double? fontSize = 20,
    required TextEditingController textController,
    bool? wrongInput = false,
    String errorMessage = "",
    required bool passwordVisible,
    required Function() onPressed}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        text,
        style: const TextStyle(fontSize: 20),
      ),
      Material(
        shadowColor: PLOShadowColor,
        elevation: 5,
        child: Container(
          width: boxWidth,
          height: boxHeight,
          decoration: BoxDecoration(
            border: Border.all(
                width: 1, color: wrongInput! ? Colors.red : Colors.black),
            borderRadius: BorderRadius.circular(6),
          ),
          child: TextField(
            obscureText: !passwordVisible,
            controller: textController,
            keyboardType: TextInputType.visiblePassword,
            style: TextStyle(fontSize: fontSize),
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(
                  passwordVisible ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: onPressed
              ),
            ),
          ),
        ),
      ),
      Text(
        wrongInput ? errorMessage : '',
        style: const TextStyle(color: Colors.red, fontSize: 12),
      )
    ],
  );
}
