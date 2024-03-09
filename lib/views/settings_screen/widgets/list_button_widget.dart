import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListButtonWidget extends StatelessWidget {
  final String title;
  final Icon? icon;
  final Function callback;
  const ListButtonWidget(
      {super.key, required this.title, this.icon, required this.callback});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => callback(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SizedBox(
          height: 55,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                icon == null ? Container() : icon!,
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
                )
              ]),
              const Icon(
                Icons.arrow_forward_ios,
                color: CupertinoColors.systemGrey,
                size: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
