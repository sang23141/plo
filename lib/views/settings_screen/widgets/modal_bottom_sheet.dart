import 'dart:io';

import 'package:plo/views/settings_screen/profile_modify_screen.dart';
import 'package:plo/views/settings_screen/settings_controller.dart';
import 'package:plo/views/settings_screen/settings_screen.dart';
import 'package:plo/views/settings_screen/widgets/list_button_widget.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;

void showChoiceModalBottomSheet(context) {
  showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    builder: (BuildContext context) {
      return SizedBox(
        height: 180,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ListButtonWidget(
                  title: "프로필 사진변경",
                  icon: const Icon(
                    Icons.camera_alt_outlined,
                    size: 33,
                    weight: 1,
                  ),
                  callback: () => {
                        Navigator.pop(context),
                        showProfilePicChangemodalBottomSheet(context)
                      }),
              ListButtonWidget(
                  title: "프로필 수정",
                  icon: const Icon(
                    Icons.edit_outlined,
                    size: 33,
                  ),
                  callback: () => {
                        Navigator.pop(context),
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ProfileModifyScreen()),
                        )
                      }),
            ],
          ),
        ),
      );
    },
  );
}

void showProfilePicChangemodalBottomSheet(context) {
  File? image;
  String photoUrl = "";

  showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    builder: (BuildContext context) {
      return SizedBox(
        height: 180,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                ListButtonWidget(
                    title: "사진 찍기",
                    icon: const Icon(
                      Icons.camera_alt_outlined,
                      size: 33,
                    ),
                    callback: () {
                      uploadChangedPictureToStorage("Camera", image, photoUrl);
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const SettingsScreen(),
                        ),
                      );
                    }),
                ListButtonWidget(
                    title: "갤러리에서 가져오기",
                    icon: const Icon(
                      Icons.picture_in_picture,
                      size: 33,
                    ),
                    callback: () {
                      uploadChangedPictureToStorage("Gallery", image, photoUrl);
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const SettingsScreen(),
                        ),
                      );
                    }),
              ],
            ),
          ),
        ),
      );
    },
  );
}
