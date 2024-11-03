import 'package:bloc/bloc.dart';
import 'package:mass_communication/features/auth/domain/usecases/get_notification_use_case.dart';
import 'event_event.dart';
import 'notification_event.dart';
import 'notification_state.dart';


class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final GetNotificationUseCase getNotificationUseCase;


  NotificationBloc({required this.getNotificationUseCase}) : super(NotificationLoading()) {

    on<LoadNotificationEvent>((event, emit) async {

      emit(NotificationLoading());

      final eventsOrFailure = await getNotificationUseCase();

      eventsOrFailure.fold(
            (failure) => emit(NotificationLoadFailure()),
            (notifications) => emit(NotificationLoadSuccess(notifications: notifications)),
      );
    });

  }
}