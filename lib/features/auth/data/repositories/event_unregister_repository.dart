import 'package:cloud_firestore/cloud_firestore.dart';

class EventUnregistrationRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> removeEventRegistration(String userId, String eventId) async {
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
    } catch (e) {
      print('Error removing event registration: $e');
    }
  }
}