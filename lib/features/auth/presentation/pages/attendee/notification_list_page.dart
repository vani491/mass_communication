
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mass_communication/features/auth/data/datasources/notification_datasource.dart';
import 'package:mass_communication/features/auth/data/repositories/notification_list_repository.dart';
import 'package:mass_communication/features/auth/domain/usecases/get_notification_use_case.dart';
import '../../bloc/notification_bloc.dart';
import '../../bloc/notification_state.dart';
import '../../bloc/notification_event.dart';
import '../../widgets/notification_list_item.dart';

class NotificationPage extends StatefulWidget {
  final NotchBottomBarController? controller;
  final String userId;

  const NotificationPage({Key? key, this.controller, required this.userId})
      : super(key: key);

  @override
  NotificationPageState createState() => NotificationPageState();
}

class NotificationPageState extends State<NotificationPage> {
  late NotificationBloc _notificationBloc;

  @override
  void initState() {
    super.initState();

    // Initialize the NotificationBloc here
    _initializeNotificationBloc();

    // Dispatch LoadNotificationEvent
    _notificationBloc.add(LoadNotificationEvent());
  }

  void _initializeNotificationBloc() {
    final notificationDataSource = NotificationDataSourceImpl(firestore: FirebaseFirestore.instance);
    final notificationListRepository = NotificationListRepositoryImpl(dataSource: notificationDataSource);
    final getNotification = GetNotificationUseCase(repository: notificationListRepository);

    // Initialize the NotificationBloc
    _notificationBloc = NotificationBloc(getNotificationUseCase: getNotification);
  }

  @override
  void dispose() {
    _notificationBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Color> iconColors = [
      Colors.purple,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.red,
      Colors.teal,
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF04224C),
        title: const Row(
          children: [
            Icon(Icons.star, size: 28, color: Colors.white),
            SizedBox(width: 10),
            Text('My Notifications', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
      body: BlocProvider(
        create: (_) => _notificationBloc,
        child: BlocBuilder<NotificationBloc, NotificationState>(
          builder: (context, state) {
            if (state is NotificationLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is NotificationLoadSuccess) {
              if (state.notifications.isEmpty) {
                return const Center(child: Text('No notifications available'));
              }
              return ListView.builder(
                itemCount: state.notifications.length,
                itemBuilder: (context, index) {
                  final notification = state.notifications[index];
                  final iconColor = iconColors[index % iconColors.length];
                  return NotificationListItem(
                    title: notification.title,
                    timestamp: notification.timestamp,
                    isRead: notification.isRead,
                    body: notification.body,
                    userId: notification.userId,
                    iconColor: iconColor,
                  );
                },
              );
            } else if (state is NotificationLoadFailure) {
              return const Center(child: Text('Failed to load notifications'));
            } else {
              return const Center(child: Text('Unexpected state'));
            }
          },
        ),
      ),
    );
  }
}
