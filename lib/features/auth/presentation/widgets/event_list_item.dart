import 'package:flutter/material.dart';

// Main Event List Item Widget
class EventListItem extends StatelessWidget {
  final String date;
  final String month;
  final String status;
  final String eventName;
  final String eventDescription;
  final String eventType;
  final String totalAttendees;
  final String location;

  const EventListItem({
    super.key,
    required this.date,
    required this.month,
    required this.status,
    required this.eventName,
    required this.eventDescription,
    required this.eventType,
    required this.totalAttendees,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Stack(
        children: [
          Card(
            color: const Color(0xFFFAFAFA),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  // Date Section
                  DateSection(date: date, month: month, status: status),

                  const SizedBox(
                      height: 130,
                      child: VerticalDivider(color: Color(0xFFDADADA))),

                  // Add vertical divider with 2dp width
                  const SizedBox(width: 8),

                  // Event Details Section
                  Expanded(
                    child: EventDetailsSection(
                      eventName: eventName,
                      eventDescription: eventDescription,
                      eventType: eventType,
                      totalAttendees: totalAttendees,
                      location: location,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 8, // Position the button at the bottom right
            right: 8, // Position the button at the bottom right
            child: ElevatedButton(
              onPressed: () {
                // Add your event registration logic here
                print('Register for event: $eventName');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Button color
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                'Register',
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Date Section Widget
class DateSection extends StatelessWidget {
  final String date;
  final String month;
  final String status;

  const DateSection({
    super.key,
    required this.date,
    required this.month,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          month,
          style: const TextStyle(fontSize: 17, fontFamily: 'Roboto'),
        ),
        Text(
          date,
          style: const TextStyle(
              fontSize: 40, fontWeight: FontWeight.bold, fontFamily: 'Roboto'),
        ),
        const SizedBox(height: 4),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            // Rounded corners with 5dp radius
            border: Border.all(
              color: const Color(0xDF2D4D17), // Border color
              width: 1, // Border width (2dp)
            ),

          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Text(
            status.toUpperCase(),
            style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.normal,
                fontFamily: 'Roboto'),
          ),
        ),
      ],
    );
  }
}

// Event Details Section Widget
class EventDetailsSection extends StatelessWidget {
  final String eventName;
  final String eventDescription;
  final String eventType;
  final String totalAttendees;
  final String location;

  const EventDetailsSection({
    super.key,
    required this.eventName,
    required this.eventDescription,
    required this.eventType,
    required this.totalAttendees,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Event name with icon
        Row(
          children: [
            const Icon(Icons.event, size: 20),
            const SizedBox(width: 8),
            Text(
              eventName,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto'),
            ),
          ],
        ),

        // Event description
        Text(
          eventDescription,
          style: const TextStyle(
              fontSize: 12, color: Colors.grey, fontFamily: 'Roboto'),
        ),
        const SizedBox(height: 8),
        // Event Type and Total Attendees
        Row(
          children: [
            // Event Type
            EventTag(label: eventType, color: Colors.orange[50]!, textColor: Colors.orange[900]!),
            const SizedBox(width: 8),
            // Total Attendees
            EventTag(
                label: 'Attendees: $totalAttendees',
                color: Colors.blue[50]!,
                textColor: Colors.blue[900]!),
          ],
        ),
        const SizedBox(height: 8),
        // Location Section
        Row(
          children: [
            const Icon(Icons.location_pin, color: Colors.blueGrey),
            const SizedBox(width: 4),
            Text(
              location,
              style: const TextStyle(
                  fontSize: 12, color: Color(0xFF3D3D3D), fontFamily: 'Roboto'),
            ),
          ],
        ),
      ],
    );
  }
}

// Reusable Event Tag Widget
class EventTag extends StatelessWidget {
  final String label;
  final Color color;
  final Color textColor;

  const EventTag({
    super.key,
    required this.label,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: Text(
        label,
        style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.normal,
            fontFamily: 'Roboto',
            color: textColor),
      ),
    );
  }
}
