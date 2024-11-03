// Use case to trigger user registration

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mass_communication/core/utils.dart';

import '../../../../core/user_preference.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/add_event_repository.dart';

class AddEvent {
  final AddEventRepository addEventRepository;

  AddEvent(this.addEventRepository);

  // Call this method when registering a new user
  Future<void> addEvent({
    required String name,
    required String description,
    required String eventType,
    required DateTime eventDate,
    required TimeOfDay startTime,
    required TimeOfDay endTime,
    required String location,
    required int capacity,
    required DateTime registrationDeadline,
  }) async {
    // Calculate the event duration in minutes
    final duration = _calculateDuration(startTime, endTime);
    String? organizerContact = UserPreferences.getMobileNumber();
    String? organizerId = UserPreferences.getUserId();
    String? organizerName = UserPreferences.getUserName();
    String? fcmToken = UserPreferences.getUserFCMToken();

    // Construct event data object
    final eventData = {
      'token': fcmToken ?? '',
      'Capacity': capacity,
      'Created_At':  FieldValue.serverTimestamp(),
      'Description': description,
      'Duration': duration,
      'End_Time': Util.timeOfDayToString(endTime),
      'Event_Date': eventDate,
      'Event_Id': Util.generateUniqueNumber().toString(), // Calculated duration
      'Event_Name': name,
      'Event_Type': eventType,
      'Location': location,
      'Organizer_Name': organizerName ?? "Suraj Singh",
      'Organizer_Contact': organizerContact ?? "9998968574",
      'Organizer_Id': organizerId ?? "001",
      'Registration_Deadline': registrationDeadline,
      'Start_Time': Util.timeOfDayToString(startTime),
      'Status': "UPCOMING",
      'Attendee_Registered': 0,
      'Ticket_Price': "100",
      'Banner_URI': "https://www.contentstadium.com/wp-content/uploads/2022/10/event-social-media-post-examples.jpg",
    };

    // Call the repository to send data to Firestore
    await addEventRepository.addEventToFirestore(eventData);
  }

  // Helper method to calculate the duration in minutes
  int _calculateDuration(TimeOfDay startTime, TimeOfDay endTime) {
    final startMinutes = startTime.hour * 60 + startTime.minute;
    final endMinutes = endTime.hour * 60 + endTime.minute;
    return endMinutes - startMinutes;
  }
}
