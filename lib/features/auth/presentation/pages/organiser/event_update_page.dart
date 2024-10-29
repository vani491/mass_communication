  import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
  import 'package:flutter/material.dart';
import 'package:mass_communication/features/auth/data/repositories/updaet_event_repository.dart';
import 'package:mass_communication/features/auth/domain/usecases/update_event.dart';
import '../../widgets/event_update_form.dart';

  class EventUpdatePage extends StatelessWidget {
    final NotchBottomBarController? controller;
    final String eventId;
    final String eventName;
    final String eventDescription;
    final String eventType;
    final String location;
    final int capacity;
    final DateTime selectedDate;
    final TimeOfDay startTime;
    final TimeOfDay endTime;
    final DateTime registrationDeadline;

    const EventUpdatePage(
        {Key? key,
        this.controller,
        required this.eventId,
        required this.eventName,
        required this.eventDescription,
        required this.eventType,
        required this.location,
        required this.capacity,
        required this.selectedDate,
        required this.startTime,
        required this.endTime,
        required this.registrationDeadline})
        : super(key: key);

    @override
    Widget build(BuildContext context) {
      // Instantiate AuthRepositoryImpl and RegisterUser
      final updateEventRepository = UpdateEventRepository();
      final updateEvent = UpdateEvent(updateEventRepository);

      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF04224C),
          title: const Row(
            children: [
              Icon(Icons.event, size: 28, color: Colors.white),
              SizedBox(width: 10),
              Text('Create Event', style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
        body: Padding(
          padding:
              const EdgeInsets.only(left: 8.0, right: 8.0, top: 8, bottom: 100),
          child:
          EventUpdateForm(
            updateEvent: updateEvent,
            eventId: eventId,
            eventName: eventName,
            eventDescription: eventDescription,
            eventType: eventType,
            location: location,
            capacity: capacity,
            selectedDate: selectedDate,
            startTime: startTime,
            endTime: endTime,
            registrationDeadline: registrationDeadline,
          ), // Use the Update form here
        ),
      );
    }
  }
