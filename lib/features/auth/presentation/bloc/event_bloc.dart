import 'package:bloc/bloc.dart';
import '../../domain/usecases/get_events.dart';
import '../../domain/usecases/get_registered_event.dart';
import 'event_event.dart';
import 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final GetEvents getEvents;
  final GetRegisteredEvents getRegisteredEvents;

  EventBloc({required this.getEvents, required this.getRegisteredEvents}) : super(EventLoading()) {

    on<LoadEventsEvent>((event, emit) async {
      emit(EventLoading());

      final eventsOrFailure = await getEvents();

      eventsOrFailure.fold(
            (failure) => emit(EventLoadFailure()),
            (events) => emit(EventLoadSuccess(events: events)),
      );
    });

    on<LoadRegisteredEvents>((event, emit) async {
      emit(EventLoading());
      final eventsOrFailure = await getRegisteredEvents();

      eventsOrFailure.fold(
            (failure) => emit(EventLoadFailure()),
            (events) => emit(EventLoadSuccess(events: events)),
      );
    });





  }
}