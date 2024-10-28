
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mass_communication/features/auth/domain/entities/event.dart';

class EventModel extends Event {
  EventModel({
    required String eventId,
    required String name,
    required String description,
    required String eventType,
    required DateTime date,
    required String location,
    required int totalAttendees,
    required String eventStatus,
    required bool isRegistered,
  }) : super(
    eventId: eventId,
    name: name,
    description: description,
    eventType: eventType,
    date: date,
    location: location,
    totalAttendees: totalAttendees,
    eventStatus: eventStatus,
    isRegistered: isRegistered
  );


  factory EventModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return EventModel(
      eventId: data['Event_Id'] ?? '',
      name: data['Event_Name'] ?? '',
      description: data['Description'] ?? '',
      eventType: data['Event_Type'] ?? '',
      date: (data['Event_Date'] as Timestamp).toDate(),
      totalAttendees: data['Attendee_Registered'] ?? 0,
      location: data['Location'] ?? '',
      eventStatus: data['Status'] ?? '',
      isRegistered: data['Is_Registered'] is bool ? data['Is_Registered'] : false,
    );
  }

}
