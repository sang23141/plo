import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plo/common/widgets/custom_app_bar.dart';
import 'package:plo/constants/firebase_contants.dart';
import 'package:plo/views/settings_screen/settings_controller.dart';
import 'package:plo/views/settings_screen/widgets/postcard.dart';

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
      appBar: const BackButtonAppBar(title: "내 게시물"),
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
