import 'package:dartz/dartz.dart';
import 'package:mass_communication/features/auth/data/datasources/notification_datasource.dart';
import 'package:mass_communication/features/auth/domain/entities/notification.dart';

import '../../../../core/failure.dart';
import '../../../../core/user_preference.dart';


abstract class NotificationListRepository {
  Future<Either<Failure, List<Notification>>> getNotification();
}

class NotificationListRepositoryImpl implements NotificationListRepository {
  final NotificationDataSource dataSource;

  NotificationListRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<Notification>>> getNotification() async {
    try {
      List<Notification> events = await dataSource.getNotification();
      return Right(events);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

}

