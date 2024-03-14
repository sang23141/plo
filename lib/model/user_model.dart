import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plo/constants/error_replacement_constants.dart';

class UserModelNameConstants {
  static const userUid = 'userUid';
  static const email = 'email';
  static const userNickname = 'nickname';
  static const userCreatedDate = 'userCreatedDate';
  static const grade = 'grade';
  static const major = 'major';
  static const profileImageUrl = "profileImageUrl";
}

class UserModel {
  final String userUid;
  final String email;
  final String userNickname;
  final Timestamp? userCreatedDate;
  final String major;
  final String grade;
  final String profileImageUrl;
  UserModel(
      {this.userUid = ErrorReplacementConstants.notSetString,
      this.email = ErrorReplacementConstants.notSetString,
      this.userCreatedDate,
      this.userNickname = ErrorReplacementConstants.notFoundString,
      this.grade = ErrorReplacementConstants.notFoundString,
      this.major = ErrorReplacementConstants.notFoundString,
      this.profileImageUrl = ErrorReplacementConstants.notFoundString});
  Map<String, dynamic> toJson() {
    return {
      UserModelNameConstants.userUid: userUid,
      UserModelNameConstants.email: email,
      UserModelNameConstants.userCreatedDate: userCreatedDate,
      UserModelNameConstants.userNickname: userNickname,
      UserModelNameConstants.grade: grade,
      UserModelNameConstants.major: major,
      UserModelNameConstants.profileImageUrl: profileImageUrl,
    };
  }

  static UserModel? fromJson(Map<String, dynamic> json) {
    try {
      return UserModel(
          userUid: json[UserModelNameConstants.userUid] ??
              ErrorReplacementConstants.notFoundString,
          email: json[UserModelNameConstants.email] ??
              ErrorReplacementConstants.notFoundString,
          userCreatedDate: json[UserModelNameConstants.userCreatedDate],
          userNickname: json[UserModelNameConstants.userNickname] ??
              ErrorReplacementConstants.notFoundString,
          grade: json[UserModelNameConstants.grade] ??
              ErrorReplacementConstants.notFoundString,
          major: json[UserModelNameConstants.major] ??
              ErrorReplacementConstants.notFoundString,
          profileImageUrl: json[UserModelNameConstants.profileImageUrl] ??
              ErrorReplacementConstants.notFoundString);
    } catch (error) {
      print("Error while converting json to User Object : ${error.toString()}");
      return null;
    }
  }
}
