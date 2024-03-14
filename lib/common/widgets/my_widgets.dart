import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget NumInputBox(BuildContext context, TextEditingController textController,
    {bool? wrongInput = false}) {
  return Material(
    elevation: 5,
    shadowColor: const Color.fromARGB(200, 0, 0, 0),
    child: Container(
      width: 75,
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
Widget textInputBox(
    {required String text,
    double fontSize = 20,
    required TextEditingController controller,
    required String? Function(String?)? validator}) {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(
      text,
      style: const TextStyle(fontSize: 20),
    ),
    TextFormField(
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Colors.black, width: 1),
            ),
            contentPadding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0)),
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(fontSize: fontSize),
        validator: validator)
  ]);
}

Container ButtonBox(
    {required String text,
    Color? color = const Color.fromARGB(255, 204, 231, 255),
    double? boxWidth = 220,
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
        shadowColor: const Color.fromARGB(200, 0, 0, 0),
        elevation: 5,
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 20,
          color: Color.fromARGB(255, 0, 0, 0),
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
    double? fontSize = 20,
    required TextEditingController controller,
    required bool passwordVisible,
    required Function() onPressed,
    required String? Function(String?)? validator}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        text,
        style: const TextStyle(fontSize: 20),
      ),
      TextFormField(
          obscureText: !passwordVisible,
          controller: controller,
          keyboardType: TextInputType.visiblePassword,
          style: TextStyle(fontSize: fontSize),
          decoration: InputDecoration(
              suffixIcon: IconButton(
                  icon: Icon(
                    passwordVisible ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: onPressed),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: Colors.black, width: 1),
              ),
              contentPadding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0)),
          validator: validator),
    ],
  );
}

PopupMenuItem<Object> dropMenuItem({
  required dynamic val,
  Widget? iconData,
  required String text,
  double? textFontSize = 15,
}) {
  return PopupMenuItem(
    value: val,
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: iconData!,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: textFontSize,
          ),
        ),
      ],
    ),
  );
}

Widget dropMenu({
  required List<PopupMenuEntry<dynamic>> Function(BuildContext) items,
  required Function(dynamic) onSelected,
  Widget? child,
}) {
  return PopupMenuButton(
    itemBuilder: items,
    onSelected: onSelected,
    child: child,
  );
}

Widget shadowBox({
  required double width,
  required double height,
  required double circularRadius,
  required Offset offset,
}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(circularRadius),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.25),
          blurRadius: 4,
          offset: offset,
        ),
      ],
    ),
  );
}

Widget pfpStack({
  required File? pfpImage,
  required ImageProvider<Object>? bgImage,
  required List<PopupMenuEntry<dynamic>> Function(BuildContext) items,
  required Function(dynamic) onSelected,
}) {
  return Stack(
    children: [
      pfpImage != null
          ? CircleAvatar(
              radius: 62,
              backgroundColor: Colors.transparent,
              backgroundImage: FileImage(pfpImage),
            )
          : CircleAvatar(
              radius: 62,
              backgroundColor: Colors.transparent,
              backgroundImage: bgImage,
            ),
      Positioned(
        right: -1,
        bottom: 0,
        child: PopupMenuButton(
          itemBuilder: items,
          onSelected: onSelected,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(
              "assets/images/profile_plus.png",
              width: 42.5,
            ),
          ),
        ),
      ),
    ],
  );
}

Widget textFormFieldErr({
  TextInputType? inputType,
  List<TextInputFormatter>? inputRules,
  required double circularRadius,
  required String? Function(String?) validator,
  TextInputAction? textInputAction,
  TextEditingController? controller,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: inputType,
    inputFormatters: inputRules,
    style: const TextStyle(color: Colors.black),
    decoration: InputDecoration(
      fillColor: Colors.white,
      filled: true,
      isDense: true,
      errorStyle: const TextStyle(
        fontSize: 12.0,
        color: Color(0xFFFF0000),
      ),
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(circularRadius),
        borderSide: const BorderSide(color: Colors.blue),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(circularRadius),
        borderSide: const BorderSide(color: Colors.black),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(circularRadius),
        borderSide: const BorderSide(color: Colors.red),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(circularRadius),
        borderSide: const BorderSide(color: Colors.black),
      ),
    ),
    validator: validator,
    textInputAction: textInputAction,
  );
}

Widget textFormFieldErrWithShadow({
  required String? textAbove,
  double? width = 300,
  double? height = 55,
  double? radius = 9.0,
  required Offset shadowOffset,
  TextEditingController? controller,
  List<TextInputFormatter>? inputRules,
  required String? Function(String?) validator,
  TextInputAction? textInputAction = TextInputAction.next,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Text(
          textAbove!,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      Stack(
        children: [
          shadowBox(
            width: width!,
            height: height!,
            circularRadius: radius!,
            offset: shadowOffset,
          ),
          textFormFieldErr(
            circularRadius: radius,
            controller: controller,
            inputRules: inputRules,
            validator: validator,
            textInputAction: textInputAction,
          ),
        ],
      ),
    ],
  );
}

Widget sizedButtonWithShadow({
  double? width = 300,
  double? height = 55,
  double? radius = 9.0,
  required Offset shadowOffset,
  required void Function()? onPressed,
  required String buttonText,
  //cum cum cum
}) {
  return Stack(
    children: [
      shadowBox(
        width: width!,
        height: height!,
        circularRadius: radius!,
        offset: shadowOffset,
      ),
      SizedBox(
        width: width,
        height: height,
        child: ElevatedButton(
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            backgroundColor: MaterialStateProperty.all(
              const Color(0xFFCCE7FF),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
          onPressed: onPressed,
          child: Text(
            buttonText,
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.black,
            ),
          ),
        ),
      )
    ],
  );
}
