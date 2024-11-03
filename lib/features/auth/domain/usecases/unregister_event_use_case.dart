// Function to unregister the user from an event and remove the details from Firestore
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/user_preference.dart';
import '../../data/repositories/event_unregister_repository.dart';

class UnregisterFromEventUseCase {
  final EventUnregistrationRepository _repository = EventUnregistrationRepository();

  Future<String> unregister(String eventId,String eventName) async {
    try {
      // Retrieve user data from shared preferences
      String? userId = UserPreferences.getUserId();

      if (userId != null) {
        // Remove the registration data from Firestore via the repository
        await _repository.removeEventRegistration(userId, eventId, eventName);

        return 'Unregistration successful for event ID: $eventId';
      } else {
        return 'User information is missing. Please ensure you are logged in.';
      }
    } catch (e) {
      return 'Error unregistering from event: $e';
    }
  }
}
