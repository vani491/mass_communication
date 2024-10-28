import 'package:equatable/equatable.dart';

abstract class EventEvent extends Equatable {
  const EventEvent();

  @override
  List<Object> get props => [];
}

class LoadEventsEvent extends EventEvent {}

class LoadRegisteredEvents extends EventEvent {}
