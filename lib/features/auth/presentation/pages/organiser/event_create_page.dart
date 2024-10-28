import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import '../../../data/repositories/add_event_repository.dart';
import '../../../domain/usecases/add_event.dart';
import '../../widgets/event_create_form.dart';


class EventCreatePage extends StatelessWidget {
  final NotchBottomBarController? controller;
  const EventCreatePage({Key? key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Instantiate AuthRepositoryImpl and RegisterUser
    final addEventRepository = AddEventRepository();
    final addEvent = AddEvent(addEventRepository);
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
      body:  Padding(
        padding: const EdgeInsets.only(left:8.0,right: 8.0, top: 8,bottom: 100),
        child: EventCreateForm(addEvent: addEvent),  // Calling the form widget here
      ),
    );
  }
}
