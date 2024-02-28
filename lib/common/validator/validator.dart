import 'package:email_vertify/constants/error_message_constants.dart';

class Validator {
  static String? validatePSUEmail(String? email) {
    if (email == null || email.isEmpty) {
      return ErrorMessageConstants.emptyStringError;
    }
    if (RegExp(r'[a-z]{3}[0-9]{1,4}@psu.edu').stringMatch(email) == null) {
      return ErrorMessageConstants.emailFormatError;
    } else {
      return null;
    }
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return ErrorMessageConstants.emptyStringError;
    }
    if (RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$').stringMatch(password) == null) {
      return ErrorMessageConstants.passwordFormatError;
    } else {
      return null;
    }
  }
static String? isSamePassword(String? password, String? passwordRetype) {
  if (password == null || password.isEmpty || passwordRetype == null || passwordRetype.isEmpty) {
    return ErrorMessageConstants.emptyStringError;
  }
  if (password != passwordRetype) {
    return ErrorMessageConstants.confirmPasswordError;
  }
    else {
      return null;
    }
  }
  static String? validateNickName(String? nickname) {
    if (nickname == null || nickname.isEmpty) {
      return ErrorMessageConstants.emptyStringError;
    }
    else {
      return null;
    }
  }
  static String? validateGrade(String? grade) {
    if (grade == null || grade.isEmpty) {
      return ErrorMessageConstants.emptyStringError;
    }
    else {
      return null;
    }
  }
  static String? validateMajor(String? major) {
    if (major == null || major.isEmpty) {
      return ErrorMessageConstants.emptyStringError;
    }
    else {
      return null;
    }
  }
}
