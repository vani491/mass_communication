import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../data/datasources/event_datasource.dart';
import '../../data/repositories/event_repository_impl.dart';
import '../../domain/usecases/get_events.dart';
import '../bloc/event_bloc.dart';
import '../bloc/event_event.dart';
import '../bloc/event_state.dart';
import '../widgets/event_list_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HomePage extends StatefulWidget {
  final NotchBottomBarController? controller;

  const HomePage({Key? key, this.controller}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late EventBloc _eventBloc;

  @override
  void initState() {
    super.initState();

    // Initialize the EventBloc here
    _initializeEventBloc();
  }

  void _initializeEventBloc() {
    final eventDataSource = EventDataSourceImpl(firestore: FirebaseFirestore.instance);
    final eventRepository = EventRepositoryImpl(dataSource: eventDataSource);
    final getEvents = GetEvents(repository: eventRepository);

    // Initialize the EventBloc and add the LoadEventsEvent
    _eventBloc = EventBloc(getEvents: getEvents)..add(LoadEventsEvent());
  }

  @override
  void dispose() {
    _eventBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF04224C),
        title: const Row(
          children: [
            Icon(Icons.home_filled, size: 28, color: Colors.white),
            SizedBox(width: 10),
            Text('Home', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
      body: BlocProvider(
        create: (_) => _eventBloc,
        child: BlocBuilder<EventBloc, EventState>(
          builder: (context, state) {
            if (state is EventLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is EventLoadSuccess) {
              return ListView.builder(
                itemCount: state.events.length,
                itemBuilder: (context, index) {
                  final event = state.events[index];
                  return EventListItem(
                    date: event.date.day.toString(),
                    month: DateFormat('MMMM').format(event.date), // Full month name
                    status: event.eventStatus,
                    eventName: event.name,
                    eventDescription: event.description,
                    eventType: event.eventType,
                    totalAttendees: event.totalAttendees.toString(),
                    location: event.location,
                  );
                },
              );
            } else {
              return const Center(child: Text('Failed to load events'));
            }
          },
        ),
      ),
    );
  }
}

