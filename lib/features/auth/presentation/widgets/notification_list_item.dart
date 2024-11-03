import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

// Main Notification List Item Widget
class NotificationListItem extends StatefulWidget {
  final String title;
  final String body;
  final bool isRead;
  final DateTime timestamp;
  final String userId;
  final Color iconColor;

  const NotificationListItem({
    super.key,
    required this.title,
    required this.body,
    required this.isRead,
    required this.timestamp,
    required this.userId,
    required this.iconColor,
  });

  @override
  NotificationListItemState createState() => NotificationListItemState();
}

class NotificationListItemState extends State<NotificationListItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Icon Section with dynamic color
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: widget.iconColor.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.notifications,
                  color: widget.iconColor,
                ),
              ),
              const SizedBox(width: 16),
              // Notification Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.body,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      timeago.format(widget.timestamp),
                      style:  TextStyle(
                        fontSize: 12,
                        color: Colors.grey[800],
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
