
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
    required int capacity,
    required String startTime,
    required String endTime,
    required DateTime registrationDeadline,
    required String organiserName,
    required String organiserContact,
    required int eventDuration,
  }) : super(
    eventId: eventId,
    name: name,
    description: description,
    eventType: eventType,
    date: date,
    location: location,
    totalAttendees: totalAttendees,
    eventStatus: eventStatus,
    isRegistered: isRegistered,
    capacity: capacity,
    startTime: startTime,
    endTime: endTime,
    registrationDeadline: registrationDeadline,
    organiserName: organiserName,
    organiserContact: organiserContact,
    eventDuration: eventDuration,
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
      capacity: data['Capacity'] ?? 0,
      startTime: data['Start_Time'] ?? '',
      endTime: data['End_Time'] ?? '',
      registrationDeadline: (data['Registration_Deadline'] as Timestamp).toDate(),
      organiserName: data['Organizer_Name'] ?? '',
      organiserContact: data['Organizer_Contact'] ?? '',
      eventDuration: data['Duration'] ?? 0,

    );
  }

}
