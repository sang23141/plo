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
  static UserModel? fromJson(Map<String, dynamic> json) {
   try {
    return UserModel (
      userUid: json[UserModelNameConstants.userUid] ?? 
      ErrorReplacementConstants.notFoundString,
      email: json[UserModelNameConstants.email] ?? 
      ErrorReplacementConstants.notFoundString,
      userCreatedDate: json[UserModelNameConstants.userCreatedDate] ,
      profile: json[UserModelNameConstants.profile] == null ? const {} : (json[UserModelNameConstants.profile]
      )


    );
   } catch (error) {
    print("Error while converting json to User Object : ${error.toString()}");
    return null;
   }
  }
}