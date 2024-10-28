// Repository for event registration
import 'package:cloud_firestore/cloud_firestore.dart';

class EventRegistrationRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addEventRegistration(Map<String, dynamic> registrationData) async {
    try {
      await _firestore.collection('event_registrations').add(registrationData);
    } catch (e) {
      print('Error adding event registration: $e');
    }
  }
}