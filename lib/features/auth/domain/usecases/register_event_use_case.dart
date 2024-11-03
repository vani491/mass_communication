import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../core/user_preference.dart';
import '../../data/repositories/event_registration_repository.dart';


// Function to register the user for an event and save the details to Firestore
class RegisterForEventUseCase {
  final EventRegistrationRepository _repository = EventRegistrationRepository();

  Future<String> register(String eventId, String eventName) async {
    try {
      // Retrieve user data from shared preferences
      String? userName = UserPreferences.getUserName();
      String? userId = UserPreferences.getUserId();
      String? fcmToken = UserPreferences.getUserFCMToken();
      if (userName != null && userId != null) {
        // Prepare the registration data
        final registrationData = {
          'eventId': eventId,
          'eventName': eventName,
          'userName': userName,
          'userId': userId,
          'token': fcmToken,
          'timestamp': FieldValue.serverTimestamp(), // Store registration time
        };

        // Add the registration data to Firestore via the repository
        await _repository.addEventRegistration(registrationData);

        return 'Registration successful for event: $eventName';
      } else {
        return 'User information is missing. Please ensure you are logged in.';
      }
    } catch (e) {
      return 'Error registering for event: $e';
    }
  }
}