//Handles Firebase registration and Firestore
//The repository is where Firebase Authentication and Firestore interaction is managed.

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

import 'notification_repository.dart';

class AddEventRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final NotificationRepository _notificationRepository = NotificationRepository();

  // Add an event in firestore
  Future<void> addEventToFirestore(Map<String, dynamic> eventData) async {
    try {
      //Add event to firestore
      await _firestore.collection('events').add(eventData);
      // Get all registered users' FCM tokens
      final attendeesSnapshot = await _firestore.collection('users').get(); // Assuming we have users collection

      // Get the token List
      List<String> tokens = [];
      for (var doc in attendeesSnapshot.docs) {
        final String? token = doc['token'];
        final String? role = doc['role'];
        final String userId = doc['userId'];

        if (token != null && role == 'Attendee') {
          tokens.add(token);
        }

        if (token != null) {
          await saveNotificationToFirestore(
            userId: userId,
            title: 'New Event Created',
            body: 'A new event "${eventData['Event_Name']}" has been added. Check out the details!',
          );
        }
      }
      // Send notifications to attendees about new event creation
      if (tokens.isNotEmpty) {
        await _notificationRepository.sendNotification(
          'New Event Created',
          'A new event "${eventData['Event_Name']}" has been added. Check out the details!',
          tokens,
        );
      }


    } catch (e) {
      // Handle other errors (Firestore, network, etc.)
      throw PlatformException(
          code: 'ADD EVENT FAILED', message: 'Failed to add event.');
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
