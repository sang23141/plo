import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:email_vertify/common/widget/my_widgets.dart';
import 'package:email_vertify/views/profile_screen.dart/profile_create_form.dart';
import 'package:email_vertify/views/profile_screen.dart/profile_create_pfp.dart';
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
<<<<<<< HEAD
}
=======
}

/*
Future<bool> nameExists2(String username) async {
  // we check first if the username doesn't exists (is not registered)
  if (!await doesUsernameExistsAlready(username)) {
    // then, we register it.
    await FirebaseFirestore.instance
        .collection("users")
        .doc("usernames")
        .set({username: true}, SetOptions(merge: true));
    return false;
  } else {
    // otherwise we print that it exists already
    print("$username already exists");
  }
  return true;
}

// we check a username existence with this method
Future<bool> nameExists(String username) async {
  // we get the registered usernames from our database
  final usernames = await FirebaseFirestore.instance
      .collection("users")
      .doc("usernames")
      .get();
  final data = usernames.data() as Map<String, dynamic>;

  // we return that if a key with that username exists
  return data.containsKey(username);
}
*/
>>>>>>> 132e0defb4d9a7d1028fc846d397b1c93b19332d
