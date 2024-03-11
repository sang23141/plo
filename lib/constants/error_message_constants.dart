class ErrorMessageConstants {
  static const String unknownError = "알 수 없는 오류가 발생했습니다. 다시 시도 해주세요.";

  static const String emailFormatError = "이메일 형식을 올바르게 써주세요";
  static const String emptyStringError = "값을 입력 해주세요";
  static const String passwordFormatError =
      "비밀번호는 8자 이상이어야 하며\n최소 1개이상의 대문자, 소문자, 숫자,\n특수문자를 포함해야 합니다";
  static const String confirmPasswordError = "비밀번호가 일치하지 않습니다";

  static const String wrongInputError = "잘못된 값입니다";

  static const String imageUploadError =
      "Sorry... There was an error uploading photos. Please try again";
  static const String postUploadError =
      "Sorry... There was an error uploading item. Please try again";

  static const String showItemWarningErrorMessage =
      "This item has been reported multiple times by other users. It could contain inappropriate content. Would you still like to view this item?";
  static const String failedToLaunchUrlMessage =
      "Failed to launch url. Please try again later";

  static const String needToLoginMessage =
      "You need to login to use this feature. Please login and try again.";
  static const String needToLoginForReportMessage =
      "To enhance security measures, we do not permit unsigned users to report a post. Please log in and try again.";
  static const String needToLoginForNotificationSetting =
      "We do not send notifications to unsigned users. To utilize this feature, please log in and try again.";
  static const String proceedWithoutLoginWarningMessage = '''
If you choose to continue without logging in, please be aware that you will not have access to the full range of exclusive features we offer. Would you like to proceed regardless?''';
  static const String duplicateNicknameMessage =
      "해당 닉네임은 중복입니다. 다른 닉네임을 사용해주세요.";
}
