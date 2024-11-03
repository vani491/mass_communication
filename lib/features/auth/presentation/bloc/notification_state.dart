import 'package:equatable/equatable.dart';
import 'package:mass_communication/features/auth/domain/entities/notification.dart';
import '../../domain/entities/event.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

class NotificationLoading extends NotificationState {}

class NotificationLoadSuccess extends NotificationState {
  final List<Notification> notifications;

  const NotificationLoadSuccess({required this.notifications});

  @override
  List<Object> get props => [notifications];
}

class NotificationLoadFailure extends NotificationState {}

