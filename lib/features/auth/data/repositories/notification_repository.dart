import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../../services/firebase_auth_service.dart';


class NotificationRepository {

  Future<void> sendNotification(String title, String body, List<String> tokens) async {
    try {

      // Generate the OAuth2 token
      final String accessToken = await FirebaseAuthService.generateAccessToken();

      // Set headers for Firebase notification
      final headers = {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json; charset=UTF-8',
      };

      // Prepare the notification payload
      final notificationBody = {
        'message': {
          'notification': {
            'title': title,
            'body': body,
          },
          'token': tokens.isNotEmpty ? tokens[0] : null, // Assuming at least one token exists
        },
      };

      // Send the request to FCM
      final response = await http.post(
        Uri.parse('https://fcm.googleapis.com/v1/projects/smart-connect-58bff/messages:send'),
        headers: headers,
        body: jsonEncode(notificationBody),
      );

      if (response.statusCode == 200) {
        print('Notification sent successfully');
      } else {
        print('Error sending notification: ${response.statusCode} - ${response.body}');
      }


    } catch (e) {
      print('Exception: $e');
    }
  }
}
