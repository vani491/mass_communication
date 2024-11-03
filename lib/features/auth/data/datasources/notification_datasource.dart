

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mass_communication/core/user_preference.dart';
import 'package:mass_communication/features/auth/domain/entities/event.dart';
import 'package:mass_communication/features/auth/domain/entities/notification.dart';

import '../models/event_model.dart';
import '../models/notification_model.dart';

abstract class NotificationDataSource {
  Future<List<Notification>> getNotification();  // This method will fetch notification from Firestore

}

class NotificationDataSourceImpl implements NotificationDataSource {
  final FirebaseFirestore firestore;

  NotificationDataSourceImpl({required this.firestore});

  @override
  Future<List<Notification>> getNotification() async {
  String? userId = UserPreferences.getUserId();
    final querySnapshot = await firestore
        .collection('notifications')
        .where('userId', isEqualTo: userId)  // Filter by userId
        .orderBy('timestamp', descending: true)  // Sort in ascending order
        .get();

    return querySnapshot.docs.map((doc) {
      return NotificationModel.fromFirestore(doc);
    }).toList();
  }



}
