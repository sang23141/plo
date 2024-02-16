import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_vertify/constants/error_replacement_constants.dart';
class UserModelNameConstants {
  static const userUid =  'userUid';
  static const email = 'email';
  static const userCreatedDate = 'userCreatedDate';
  static const profile = 'profile';
}
class UserModel {
  final String userUid;
  final String email;
  final Timestamp? userCreatedDate;
  final Map<String, dynamic> profile; 
  UserModel ({
    this.userUid = ErrorReplacementConstants.notSetString,
    this.email = ErrorReplacementConstants.notSetString,
    this.userCreatedDate,
    this.profile= const {},

  });
  Map<String, dynamic> toJson() {
    return {
      UserModelNameConstants.userUid: userUid,
      UserModelNameConstants.email: email,
      UserModelNameConstants.userCreatedDate: userCreatedDate,
      UserModelNameConstants.profile: {
        for (final entry in profile.entries)
        entry.key.toString(): entry.value
      }
    };
  }
}