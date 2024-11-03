class Notification {
  final String title;
  final String body;
  final bool isRead;
  final DateTime timestamp;
  final String userId;


  Notification({
    required this.title,
    required this.body,
    required this.isRead,
    required this.timestamp,
    required this.userId,

  });
}
