import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'notification_repository.dart';

class UpdateEventRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final NotificationRepository _notificationRepository = NotificationRepository();

  // Update an event in Firestore
  Future<void> updateEventInFirestore(String eventId, Map<String, dynamic> updatedEventData) async {
    try {

      // Update the event in Firestore using the provided eventId
      QuerySnapshot querySnapshot = await _firestore
          .collection('events')
          .where('Event_Id', isEqualTo: eventId)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        String docId = querySnapshot.docs.first.id;

        await _firestore.collection('events').doc(docId).update(updatedEventData);

        // Get all attendees registered for this event
        final attendeesSnapshot = await _firestore
            .collection('event_registrations')
            .where('eventId', isEqualTo: eventId)
            .get();

        List<String> tokens = [];
        for (var doc in attendeesSnapshot.docs) {
          final String? token = doc['token'];
          final String userId = doc['userId'];

          if (token != null) {
            tokens.add(token);
          }

          if (token != null) {
            await saveNotificationToFirestore(
              userId: userId,
              title: 'Event Updated',
              body: 'An event "${updatedEventData['Event_Name']}" has been updated. Check out the what are the updates!',
            );
          }
        }

        // Send notifications to attendees about event update
        if (tokens.isNotEmpty) {
          await _notificationRepository.sendNotification(
            'Event Updated',
            'The event "${updatedEventData['Event_Name']}" has been updated. Please check the latest details!',
            tokens,
          );
        }
      } else {
        // Handle the case where no document was found for the given eventId
        if (kDebugMode) {
          print('Event not found');
        }
      }
    } catch (e) {
      // Handle other errors (Firestore, network, etc.)
      throw PlatformException(
          code: 'UPDATE EVENT FAILED', message: 'Failed to update event.');
    }
  }

  Future<void> saveNotificationToFirestore({
    required String userId,
    required String title,
    required String body,
  }) async {
    try {
      await _firestore.collection('notifications').add({
        'userId': userId,
        'title': title,
        'body': body,
        'timestamp': FieldValue.serverTimestamp(),
        'isRead': false,
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error saving notification: $e');
      }
    }
  }


}
