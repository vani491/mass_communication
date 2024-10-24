
import 'package:dartz/dartz.dart'; // Use for Either
import '../../../../core/failure.dart';
import '../../data/repositories/event_repository.dart';
import '../entities/event.dart';


class GetEvents {
  final EventRepository repository;

  GetEvents({required this.repository});

  Future<Either<Failure, List<Event>>> call() {
    return repository.getEvents();
  }
}
