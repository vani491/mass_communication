import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'notification_repository.dart';

class EventUnregistrationRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final NotificationRepository _notificationRepository = NotificationRepository();

  Future<void> removeEventRegistration(String userId, String eventId, String eventName) async {
    try {
      // Query the document where userId and eventId match
      QuerySnapshot snapshot = await _firestore
          .collection('event_registrations')
          .where('userId', isEqualTo: userId)
          .where('eventId', isEqualTo: eventId)
          .get();

      // Delete the matching document(s)
      for (DocumentSnapshot doc in snapshot.docs) {
        await doc.reference.delete();
      }


      // Decrement Attendee_Registered in Firestore by querying for eventId
      final querySnapshot = await _firestore
          .collection('events')
          .where('Event_Id', isEqualTo: eventId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Assuming eventId is unique, there should be only one matching document
        final docRef = querySnapshot.docs.first.reference;

        await docRef.update({
          'Attendee_Registered': FieldValue.increment(-1),
        });
      } else {
        if (kDebugMode) {
          print('Event not found for given eventId: ${eventId}');
        }
      }


      // Get event data for a particular event ID
      final eventSnapshot = await _firestore.collection('events').where('Event_Id', isEqualTo: eventId).get(); // Assuming we have users collection
      for (var doc in eventSnapshot.docs) {
        final String? organiserId = doc['Organizer_Id'];

        // Get organiser' FCM tokens
        final organiserSnapshot = await _firestore.collection('users').where('userId', isEqualTo: organiserId).get(); // Assuming we have users collection

        // Get the token List
        List<String> tokens = [];
        for (var doc in organiserSnapshot.docs) {
          final String? token = doc['token'];
          final String userId = doc['userId'];

          if (token != null) {
            tokens.add(token);
          }

          if (token != null) {
            await saveNotificationToFirestore(
              userId: userId,
              title: 'Attendee Unregistered',
              body:  'An old attendee has been unregistered from a $eventName event. Check out the details!',
            );
          }
        }

        // Send notifications to attendees about new event creation
        if (tokens.isNotEmpty) {
          await _notificationRepository.sendNotification(
            'Attendee Unregistered',
            'An old attendee has been unregistered from a $eventName event. Check out the details!',
            tokens,
          );
        }

      }

    } catch (e) {
      print('Error removing event registration: $e');
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
      print('Error saving notification: $e');
    }
  }

}