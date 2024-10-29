import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class UpdateEventRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
      } else {
        // Handle the case where no document was found for the given eventId
        print('Event not found');
      }
    } catch (e) {
      // Handle other errors (Firestore, network, etc.)
      throw PlatformException(
          code: 'UPDATE EVENT FAILED', message: 'Failed to update event.');
    }
  }
}
