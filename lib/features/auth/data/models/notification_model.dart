
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mass_communication/features/auth/domain/entities/event.dart';
import 'package:mass_communication/features/auth/domain/entities/notification.dart';

class NotificationModel extends Notification {
  NotificationModel({
    required String title,
    required String body,
    required bool isRead,
    required String userId,
    required DateTime timestamp,

  }) : super(
    title: title,
    body: body,
    isRead: isRead,
    timestamp: timestamp,
    userId: userId,

  );

  factory NotificationModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return NotificationModel(
      title: data['title'] ?? '',
      body: data['body'] ?? '',
      isRead: data['isRead'] ?? false,
      userId: data['userId'] ?? '',
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }

}
