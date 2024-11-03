import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mass_communication/core/utils.dart';
import '../../domain/usecases/register_event_use_case.dart';
import '../../domain/usecases/unregister_event_use_case.dart';
import '../bloc/event_bloc.dart';
import '../bloc/event_event.dart';

// Main Event List Item Widget
class MyEventListItem extends StatefulWidget {
  final String date;
  final String month;
  final String eventName;
  final String eventId;
  final String eventDescription;
  final String eventType;
  final String totalAttendees;
  final String organiserName;
  final String organiserContact;
  final String eventDuration;
  final bool isRegistered;
  final String status;
  final String location;
  final String startTime;

  const MyEventListItem({
    super.key,
    required this.date,
    required this.month,
    required this.eventName,
    required this.eventId,
    required this.eventDescription,
    required this.eventType,
    required this.totalAttendees,
    required this.organiserName,
    required this.organiserContact,
    required this.eventDuration,
    required this.isRegistered,
    required this.status,
    required this.location,
    required this.startTime,
  });

  @override
  MyEventListItemState createState() => MyEventListItemState();
}

class MyEventListItemState extends State<MyEventListItem> {


  @override
  void initState() {
    super.initState();
  }

  // Method to handle event unregistration and provide feedback to the user
  Future<void> _handleUnregistration(String eventId, String eventName) async {
    // Show loading indicator
    Util.showLoadingIndicator(context, "Unregistering...");

    final registerUseCase = UnregisterFromEventUseCase();
    String result = await registerUseCase.unregister(eventId, eventName);

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
      context.read<EventBloc>().add(LoadEventsEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 5),
                      // Event Image Placeholder
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: const DecorationImage(
                            image: AssetImage('assets/images/meetup.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      const SizedBox(height: 15),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          // Rounded corners with 5dp radius
                          border: Border.all(
                            color: const Color(0xDF538133), // Border color
                            width: 1, // Border width (2dp)
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        child: Row(
                          children: [
                            const Icon(Icons.add_business_outlined,
                                size: 14, color: Color(0xDF538133)),
                            const SizedBox(width: 4),
                            Text(
                              widget.eventType,
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xDF3B5D23),
                                  fontFamily: 'Roboto'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  // Event Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Event Name
                        Text(
                          widget.eventName,
                          style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF04224C),
                              fontFamily: 'Roboto'),
                        ),
                        const SizedBox(height: 4),
                        // Event Type
                        Text(
                          widget.eventDescription,
                          style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              fontFamily: 'Roboto'),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        // Event Date with Start Time
                        Row(
                          children: [
                            Icon(Icons.access_time,
                                size: 16, color: Colors.grey[800]!),
                            const SizedBox(width: 4),
                            Text(
                              '${widget.date} ${widget.month} Start at ${widget.startTime}',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey[600]!,
                                  fontFamily: 'Roboto'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // Event Duration and Attendees
                        Row(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.timelapse,
                                    size: 16, color: Colors.blue[900]!),
                                const SizedBox(width: 4),
                                Text(
                                  '${widget.eventDuration} mins',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.blue[900]!,
                                      fontFamily: 'Roboto'),
                                ),
                              ],
                            ),
                            const SizedBox(width: 16),
                            Row(
                              children: [
                                Icon(Icons.people,
                                    size: 16, color: Colors.orange[800]),
                                const SizedBox(width: 4),
                                Text(
                                  '${widget.totalAttendees} Attendees',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.orange[900],
                                      fontFamily: 'Roboto'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Favorite Icon
                  IconButton(
                    icon: const Icon(Icons.favorite_border, color: Colors.red),
                    onPressed: () {
                      // Handle favorite action
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Organiser Contact and Unregister Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Organiser Details
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Organiser Contact',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF646363),
                            fontFamily: 'Roboto'),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${widget.organiserName}, ${widget.organiserContact}',
                        style: const TextStyle(
                            fontSize: 11,
                            color: Colors.grey,
                            fontFamily: 'Roboto'),
                      ),
                    ],
                  ),
                  // Unregister Button
                  ElevatedButton(
                    onPressed: widget.isRegistered
                        ? () async {
                            await _handleUnregistration(widget.eventId, widget.eventName);
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: widget.isRegistered ? Colors.red : Colors.grey,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: const Text(
                      'Unregister',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontFamily: 'Roboto'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
