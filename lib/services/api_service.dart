import 'dart:convert';

import 'package:plo/model/email_response_model.dart';
import 'package:http/http.dart' as http;

class EmailAPIService {
  static var client = http.Client();

  static Future<LoginResponseModel> otpLogin(String email) async {
    var url = Uri.parse(
        'https://us-central1-project-plo.cloudfunctions.net/api/api/otp-login');

    var response = await client.post(
      url,
      headers: {'Content-type': "application/json"},
      body: jsonEncode(
        {"email": email},
      ),
    );

    return loginResponseModel(response.body);
  }

  static Future<LoginResponseModel> verifyOTP(
    String email,
    String otpHash,
    String otpCode,
  ) async {
    var url = Uri.parse(
        'https://us-central1-project-plo.cloudfunctions.net/api/api/otp-verify');

    var response = await client.post(
      url,
      headers: {'Content-type': "application/json"},
      body: jsonEncode(
        {
          "email": email,
          "otp": otpCode,
          "hash": otpHash,
        },
      ),
    );

    return loginResponseModel(response.body);
  }
}
