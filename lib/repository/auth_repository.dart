import 'dart:io';

import 'package:email_vertify/repository/firebasestoroage_respository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';


class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> signUpUser({
    required String email,
    required String password,
    required String nickname,
    required String grade,
    required String major,
    required File? file,
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty ||nickname.isNotEmpty ||grade.isNotEmpty ||major.isNotEmpty || file != null) {
        UserCredential cred = await  _auth.createUserWithEmailAndPassword(email: email, password: password);
        
        String photoUrl = await StorageMethods().uploadImageToStorage('profilePics', file!, false);
        //이런 방식으로 하면 doc uid가 자동으로 auth uid로 생성이 됨
        _firestore.collection('users').doc(cred.user!.uid).set({
          'grade' : grade,
          'major' : major,
          'nickname': nickname,
          'user_pfp': photoUrl,

        });

        res = 'success';
      }
      
    } 
    catch (err) {
      res = err.toString();
      
    }
    return res;
  }
}