import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:email_vertify/widget/my_widgets.dart';

//프로필 사진 추가 Stateful Stack
class ProfileStack extends StatefulWidget {
  const ProfileStack({super.key});

  @override
  State<ProfileStack> createState() => _ProfileStackState();
}

class _ProfileStackState extends State<ProfileStack> {
  Uint8List? _image;
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
              if (value == "photo") {
                //captureImage(); --> 사진 찍기
              } else if (value == "gallery") {
                //selectImage(); --> 갤러리에서 가져오기
              }
            },
          ),
        ),
      ],
    );
  }
}
