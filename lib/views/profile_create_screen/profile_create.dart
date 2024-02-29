import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:email_vertify/common/widget/my_widgets.dart';
import 'package:email_vertify/views/profile_create_screen/profile_create_form.dart';
import 'package:email_vertify/views/profile_create_screen/profile_create_pfp.dart';
//import 'package:image_picker/image_picker.dart';
//import 'package:my_plo_personal/imagePicker.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'firebase_options.dart';

//firebase backend
//final db = FirebaseFirestore.instance;
//var usernamesDocRef = db.collection("users").doc("usernames");

class ProfileBG extends StatelessWidget {
  const ProfileBG({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: const Profile(),
        ),
      ),
    );
  }
}

class Profile extends StatelessWidget {
  const Profile({super.key});

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
      body: Container(
        alignment: Alignment.center,
        child: const SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //프로필 사진 추가 Stateful Stack
              ProfileStack(),
              //"프로필 설정"
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "프로필 설정",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              //프로필 상세 입력 Stateful TextFormField 및 확인 버튼
              ProfileForm(),
            ],
          ),
        ),
      ),
    );
  }
}

/*
//닉네임 duplicate checking
Future<bool> nameExists(String username) async {
  final QuerySnapshot query =
      await db.collection("users").where("nickname", isEqualTo: username).get();
  final List<DocumentSnapshot> docs = query.docs;
  return docs.length == 1;
}
*/
void main() async {
  bool c = await getstatus();
  print(c);
}

Future<bool> getMockData() {
  return Future.value(false);
}

Future<bool> getstatus() async {
  bool message = await getMockData();
  return (message); // will print one on console.
}
