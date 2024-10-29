import 'package:http/http.dart' as http;
import 'dart:convert';

class NotificationRepository {
  final String serverKey = 'YOUR_SERVER_KEY_HERE';

  Future<void> sendNotification(String title, String body, String token) async {
    try {
      final response = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverKey',
        },
        body: jsonEncode(<String, dynamic>{
          'notification': <String, dynamic>{
            'title': title,
            'body': body,
          },
          'priority': 'high',
          'to': token,
        }),
      );

      if (response.statusCode == 200) {
        print('Notification sent successfully');
      } else {
        print('Error sending notification: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }
}
