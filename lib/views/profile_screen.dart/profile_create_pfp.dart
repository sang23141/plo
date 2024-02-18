import 'dart:io';

import 'package:email_vertify/model/types/return_type.dart';
import 'package:email_vertify/repository/image_picker_repository.dart';
import 'package:email_vertify/views/profile_screen.dart/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:email_vertify/common/widget/my_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

//프로필 사진 추가 Stateful Stack
// class SeletedFileNotifier extends StateNotifier<File?> {
//   SelectedFileNotifier() : super(null);
//   void setFile(File? file) {
//     state = file;
//   }
// }

class ProfileStack extends ConsumerStatefulWidget {
  const ProfileStack({super.key});

  @override
  ConsumerState<ProfileStack> createState() => _ProfileStackState();
}

class _ProfileStackState extends ConsumerState<ProfileStack> {
  Uint8List? _image;

  void selectImage(ImageSource source) async {
    final pickedImage = ref.read(imagePickerRepositoryProvider);
    ReturnType result;
    if (source == ImageSource.camera) {
      result = await pickedImage.pickImageFromCamera(source);
    } else {
      result = await pickedImage.pickImageFromGallery();
    }
    if (result is SuccessReturnType && result.data != null) {
      File file = result.data;
      ref.read(selectedFile.notifier).setFile(file);
      setState(() {
        _image = file.readAsBytesSync();
      });
    } else if (result is ErrorReturnType) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result.message!)));
    }
  }

  /*
  void captureImage() async {
    Uint8List img = await pickImage(ImageSource.camera);
    setState(() {
      _image = img;
    });
  }

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }
  */

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _image != null
            ? CircleAvatar(
                radius: 62,
                backgroundColor: Colors.transparent,
                backgroundImage: MemoryImage(_image!),
              )
            : const CircleAvatar(
                radius: 62,
                backgroundColor: Colors.transparent,
                backgroundImage:
                    AssetImage('assets/images/profile_default.png'),
              ),
        //이미지 추가 팝업메뉴 버튼
        Positioned(
          right: -1,
          bottom: 0,
          child: PopupMenuButton(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(
                "assets/images/profile_plus.png",
                width: 42.5,
              ),
            ),
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              dropMenuItem(
                val: "photo",
                iconData: const Icon(
                  Icons.camera_alt_outlined,
                  size: 25,
                ),
                text: "사진 찍기",
                textFontSize: 15,
              ),
              dropMenuItem(
                val: "gallery",
                iconData: const Icon(
                  Icons.collections_outlined,
                  size: 25,
                ),
                text: "갤러리에서 가져오기",
                textFontSize: 15,
              ),
            ],
            onSelected: (value) {
              selectImage;
            },
          ),
        ),
      ],
    );
  }
}

