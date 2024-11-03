import 'dart:convert';
import 'package:googleapis_auth/auth_io.dart';
import 'package:flutter/services.dart';

class FirebaseAuthService {
  static Future<String> generateAccessToken() async {
    final String jsonString = await rootBundle.loadString('assets/smart-connect-58bff-firebase-adminsdk-bnzxi-4e5fd090ea.json');
    final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    final credentials = ServiceAccountCredentials.fromJson(jsonMap);
    final scopes = ['https://www.googleapis.com/auth/cloud-platform'];

    final client = await clientViaServiceAccount(credentials, scopes);

    return client.credentials.accessToken.data;
  }
}
