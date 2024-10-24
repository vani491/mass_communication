class Event {
  final String eventId;
  final String name;
  final String description;
  final String eventType;
  final DateTime date;
  final String location;
  final String totalAttendees;
  final String eventStatus;

  Event({
    required this.eventId,
    required this.name,
    required this.description,
    required this.eventType,
    required this.date,
    required this.location,
    required this.totalAttendees,
    required this.eventStatus
  });
}
