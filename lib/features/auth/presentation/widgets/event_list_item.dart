import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mass_communication/core/utils.dart';
import '../../domain/usecases/register_event_use_case.dart';

// Main Event List Item Widget
class EventListItem extends StatefulWidget {
  final String date;
  final String month;
  final String status;
  final String eventName;
  final String eventId;
  final String eventDescription;
  final String eventType;
  final String totalAttendees;
  final String location;
  final bool isRegistered;

  const EventListItem({
    super.key,
    required this.date,
    required this.month,
    required this.status,
    required this.eventName,
    required this.eventId,
    required this.eventDescription,
    required this.eventType,
    required this.totalAttendees,
    required this.location,
    required this.isRegistered,
  });

  @override
  _EventListItemState createState() => _EventListItemState();
}

class _EventListItemState extends State<EventListItem> {
  late bool isRegistered;
  late int totalAttendees;

  @override
  void initState() {
    super.initState();
    // Initialize the local variable with the widget property
    isRegistered = widget.isRegistered;
    totalAttendees = int.parse(widget.totalAttendees.toString());
  }

  // Method to handle event registration and provide feedback to the user
  Future<void> _handleEventRegistration(
      String eventId, String eventName) async {
    // Show loading indicator
    Util.showLoadingIndicator(context, "Registering...");

    final registerUseCase = RegisterForEventUseCase();
    String result = await registerUseCase.register(eventId, eventName);

    // Dismiss loading indicator only if mounted
    if (mounted) {
      Navigator.of(context).pop();
    }

    // Show success or error message to the user
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(result),
        backgroundColor:
            result.contains('successful') ? Colors.green : Colors.red,
      ),
    );

    // Update registration status if successful
    if (result.contains('successful')) {
      setState(() {
        isRegistered = true;
        totalAttendees = totalAttendees+1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Card(
        color: const Color(0xFFFAFAFA),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  // Date Section
                  DateSection(
                      date: widget.date,
                      month: widget.month,
                      status: widget.status),
                  const SizedBox(
                      height: 130,
                      child: VerticalDivider(color: Color(0xFFDADADA))),
                  // Add vertical divider with 2dp width
                  const SizedBox(width: 8),
                  // Event Details Section
                  Expanded(
                    child: EventDetailsSection(
                      eventName: widget.eventName,
                      eventDescription: widget.eventDescription,
                      eventType: widget.eventType,
                      totalAttendees: totalAttendees.toString(),
                      location: widget.location,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Register Button below the event details section
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: isRegistered
                      ? null
                      : () async {
                          await _handleEventRegistration(
                              widget.eventId, widget.eventName);
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isRegistered ? Colors.grey : Colors.green,
                    // Button color
                    padding: const EdgeInsets.only(
                        top: 0, bottom: 0, left: 12, right: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Text(
                    isRegistered ? 'Already Registered' : 'Register Here >>',
                    style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontFamily: 'Roboto'),
                  ),
                ),
              )
            ],
          ),
        ),
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
            Text(
              eventName,
              style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Roboto'),
            ),
          ],
        ),

        // Event description
        Text(
          eventDescription,
          style: const TextStyle(
              fontSize: 12, color: Colors.grey, fontFamily: 'Roboto'),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 8),
        // Event Type and Total Attendees
        Row(
          children: [
            // Event Type
            EventTag(
                label: 'Event Type: $eventType',
                color: Colors.orange[50]!,
                textColor: Colors.orange[900]!),
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
            Flexible(
              child: Text(
                location,
                style: const TextStyle(
                    fontSize: 12, color: Color(0xFF3D3D3D), fontFamily: 'Roboto'),
                maxLines: 2, // Limit to one line
                overflow: TextOverflow.ellipsis, // Add ellipsis if the text overflows
              ),
            )

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
