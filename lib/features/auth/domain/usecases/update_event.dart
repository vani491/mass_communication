import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mass_communication/core/utils.dart';
import '../../../../core/user_preference.dart';
import '../../data/repositories/updaet_event_repository.dart';


class UpdateEvent {
  final UpdateEventRepository updateEventRepository;

  UpdateEvent(this.updateEventRepository);

  // Call this method to update an existing event
  Future<void> updateEvent({
    required String eventId,
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

    // Construct updated event data object
    final updatedEventData = {
      'Capacity': capacity,
      'Description': description,
      'Duration': duration,
      'End_Time': Util.timeOfDayToString(endTime),
      'Event_Date': eventDate,
      'Event_Name': name,
      'Event_Type': eventType,
      'Location': location,
      'Organizer_Contact': organizerContact ?? "9998968574",
      'Organizer_Id': organizerId ?? "001",
      'Registration_Deadline': registrationDeadline,
      'Start_Time': Util.timeOfDayToString(startTime),
      'Status': "UPCOMING",
      'Attendee_Registered': 0,
      'Ticket_Price': "100",
      'Banner_URI': "https://www.contentstadium.com/wp-content/uploads/2022/10/event-social-media-post-examples.jpg",

      // Additional fields if needed
    };

    // Call the repository to update the event in Firestore
    await updateEventRepository.updateEventInFirestore(eventId, updatedEventData);
  }

  // Helper method to calculate the duration in minutes
  int _calculateDuration(TimeOfDay startTime, TimeOfDay endTime) {
    final startMinutes = startTime.hour * 60 + startTime.minute;
    final endMinutes = endTime.hour * 60 + endTime.minute;
    return endMinutes - startMinutes;
  }
}
