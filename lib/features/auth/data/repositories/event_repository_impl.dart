import 'package:dartz/dartz.dart';
import '../../../../core/failure.dart';
import '../../domain/entities/event.dart';
import '../datasources/event_datasource.dart';
import 'event_repository.dart';


class EventRepositoryImpl implements EventRepository {
  final EventDataSource dataSource;

  EventRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<Event>>> getEvents() async {
    try {
      final events = await dataSource.getEvents();  // Using the dataSource to fetch events
      return Right(events);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}

