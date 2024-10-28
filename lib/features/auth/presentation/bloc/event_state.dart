import 'package:equatable/equatable.dart';
import '../../domain/entities/event.dart';

abstract class EventState extends Equatable {
  const EventState();

  @override
  List<Object> get props => [];
}

class EventLoading extends EventState {}

class EventLoadSuccess extends EventState {
  final List<Event> events;

  const EventLoadSuccess({required this.events});

  @override
  List<Object> get props => [events];
}

class EventLoadFailure extends EventState {}

