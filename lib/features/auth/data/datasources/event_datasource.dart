

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mass_communication/features/auth/domain/entities/event.dart';

import '../models/event_model.dart';

abstract class EventDataSource {
  Future<List<Event>> getEvents();  // This method will fetch events from Firestore
}

class EventDataSourceImpl implements EventDataSource {
  final FirebaseFirestore firestore;

  EventDataSourceImpl({required this.firestore});

  @override
  Future<List<Event>> getEvents() async {
    final querySnapshot = await firestore.collection('events').get();
    return querySnapshot.docs.map((doc) {
      return EventModel.fromFirestore(doc);  // Assuming EventModel has a method to map Firestore data
    }).toList();
  }
}
