// UseCase
import 'package:dartz/dartz.dart'; // Use for Either
import '../../../../core/failure.dart';
import '../../data/repositories/event_repository.dart';
import '../entities/event.dart';


class GetRegisteredEvents {
  final EventRepository repository;

  GetRegisteredEvents({required this.repository});

  Future<Either<Failure, List<Event>>> call() {
    return repository.getRegisteredEvents();
  }
}
