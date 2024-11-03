// UseCase
import 'package:dartz/dartz.dart'; // Use for Either
import 'package:mass_communication/features/auth/data/repositories/notification_list_repository.dart';
import 'package:mass_communication/features/auth/domain/entities/notification.dart';
import '../../../../core/failure.dart';
import '../../data/repositories/event_repository.dart';
import '../entities/event.dart';

class GetNotificationUseCase {
  final NotificationListRepository repository;

  GetNotificationUseCase({required this.repository});

  Future<Either<Failure, List<Notification>>> call() {
    return repository.getNotification();
  }
}
