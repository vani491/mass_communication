import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mass_communication/core/utils.dart';
import '../../domain/usecases/register_event_use_case.dart';
import '../bloc/event_bloc.dart';
import '../bloc/event_event.dart';
import '../pages/organiser/event_create_page.dart';
import '../pages/organiser/event_update_page.dart';

// Main Event List Item Widget
class OrganiserEventListItem extends StatefulWidget {
  final String date;
  final String month;
  final String status;
  final String eventName;
  final String eventId;
  final String eventDescription;
  final String eventType;
  final String totalAttendees;
  final String location;
  final int capacity;
  final DateTime eventDate;
  final bool isRegistered;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final DateTime registrationDeadline;

  const OrganiserEventListItem({
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
    required this.capacity,
    required this.isRegistered, required this.eventDate, required this.startTime, required this.endTime, required this.registrationDeadline,
  });

  @override
  OrganiserEventListItemState createState() => OrganiserEventListItemState();
}

class OrganiserEventListItemState extends State<OrganiserEventListItem> {
  @override
  void initState() {
    super.initState();
    // Initialize the local variable with the widget property
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
                      totalAttendees: widget.totalAttendees,
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
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EventUpdatePage(
                          key: widget.key,
                          controller: null,
                          eventId: widget.eventId,
                          eventName: widget.eventName,
                          eventDescription: widget.eventDescription,
                          eventType: widget.eventType,
                          location: widget.location,
                          capacity: widget.capacity, // Ensure you have correct capacity value
                          selectedDate: widget.eventDate,
                          startTime: widget.startTime,
                          endTime: widget.endTime,
                          registrationDeadline: widget.registrationDeadline,
                        ),
                      ),
                    );

                    // If result is true, refresh the event list
                    if (result == true) {
                      BlocProvider.of<EventBloc>(context).add(LoadEventsEvent());
                    }
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    // Button color
                    padding: const EdgeInsets.only(
                        top: 0, bottom: 0, left: 12, right: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: const Text(
                    'Update Event',
                    style: TextStyle(
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
            const Icon(Icons.event, size: 20),
            const SizedBox(width: 8),
            Text(
              eventName,
              style: const TextStyle(
                  fontSize: 17,
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
                    fontSize: 12,
                    color: Color(0xFF3D3D3D),
                    fontFamily: 'Roboto'),
                maxLines: 2, // Limit to one line
                overflow:
                    TextOverflow.ellipsis, // Add ellipsis if the text overflows
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
