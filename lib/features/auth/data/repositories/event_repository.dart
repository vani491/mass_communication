import 'package:dartz/dartz.dart';
import 'package:mass_communication/features/auth/domain/entities/event.dart';

import '../../../../core/failure.dart';

abstract class EventRepository {
  Future<Either<Failure, List<Event>>> getEvents();
}
