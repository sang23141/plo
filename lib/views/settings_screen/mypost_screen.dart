import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_vertify/constants/firebase_contants.dart';
import 'package:email_vertify/views/settings_screen/settings_controller.dart';
import 'package:email_vertify/views/settings_screen/widgets/postcard.dart';
import 'package:flutter/material.dart';

class MyPostScreen extends StatefulWidget {
  const MyPostScreen({super.key});

  @override
  State<MyPostScreen> createState() => _MyPostScreenState();
}

class _MyPostScreenState extends State<MyPostScreen> {
  final _controller = ScrollController();
  DocumentSnapshot? lastDocument;
  List<DocumentSnapshot> documentList = [];

  @override
  void initState() {
    super.initState();
    getPosts(FirebaseConstants.postcollectionName, lastDocument, documentList);
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        getPosts(
            FirebaseConstants.postcollectionName, lastDocument, documentList);
      }
    });
  }

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
        title: const Text(
          "내 게시물",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        itemCount: documentList.length,
        itemBuilder: (context, index) => PostCard(
          snap: documentList[index].data(), //FIXME
        ),
        controller: _controller,
      ),
    );
  }
}
