import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_vertify/constants/firebase_contants.dart';
import 'package:email_vertify/model/user_model.dart';

class FirebaseUserRepository {
  final usercollectionName = FirebaseConstants.usercollectionName;
  void _logHelper(String typeofAction, String funcitonName) {
    log("Firestore was Used ($typeofAction) in $funcitonName in FirebaseUserRepository");
  }
  Future<bool> uploadUserModel(UserModel user) async {
    try {
      await FirebaseFirestore.instance
          .collection(usercollectionName)
          .doc(user.userUid)
          .set(user.toJson());
      _logHelper("Set", "uploadUserModel");
      return true;
    } catch (error) {
      log("UserRepository uploadUserModel error: $error");
      return false;
    }
  }
}
