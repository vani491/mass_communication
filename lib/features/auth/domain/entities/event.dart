class Event {
  final String eventId;
  final String name;
  final String description;
  final String eventType;
  final DateTime date;
  final String location;
  final int totalAttendees;
  final String eventStatus;
  bool isRegistered;
  final int capacity;
  final String startTime;
  final String endTime;
  final DateTime registrationDeadline;
  final String organiserName;
  final String organiserContact;
  final int eventDuration;

  Event({
    required this.eventId,
    required this.name,
    required this.description,
    required this.eventType,
    required this.date,
    required this.location,
    required this.totalAttendees,
    required this.eventStatus,
    required this.isRegistered,
    required this.capacity,
    required this.startTime,
    required this.endTime,
    required this.registrationDeadline,
    required this.organiserName,
    required this.organiserContact,
    required this.eventDuration,
  });
}
