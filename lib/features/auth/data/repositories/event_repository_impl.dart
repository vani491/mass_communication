import 'package:dartz/dartz.dart';
import '../../../../core/failure.dart';
import '../../../../core/user_preference.dart';
import '../../domain/entities/event.dart';
import '../datasources/event_datasource.dart';
import 'event_repository.dart';

class EventRepositoryImpl implements EventRepository {
  final EventDataSource dataSource;

  EventRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<Event>>> getEvents() async {
    try {
      List<Event> events = await dataSource.getEvents();
      String? userId = UserPreferences.getUserId();
      // Get registration status for each event for the current user and update the event list
      for (var event in events) {
        bool isRegistered =
            await dataSource.isUserRegistered(event.eventId, userId ?? "");
        event.isRegistered =
            isRegistered; // Assuming Event model has an 'isRegistered' field
      }
      return Right(events);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Event>>> getRegisteredEvents() async {
    try {
      Either<Failure, List<Event>> result = await getEvents();
      return result.fold(
        (failure) => Left(ServerFailure()),
        (events) => Right(events.where((event) => event.isRegistered).toList()),
      );
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
