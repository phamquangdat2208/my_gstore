import 'package:my_gstore/presentation/journey/feature/screens/Notification/model/notification_model.dart';

abstract class NotificationState {
  final List<NotificationModels>? notifications;
  final bool isLastData;

  NotificationState({this.notifications, this.isLastData = false});
}

class NotificationInitState extends NotificationState {}

class NotificationGettingDataState extends NotificationState {}

class NotificationGotDataState extends NotificationState {
  NotificationGotDataState(List<NotificationModels>? notifications, {bool isLastData = false})
      : super(
    notifications: notifications,
    isLastData: isLastData,
  );
}

class NotificationGetFailState extends NotificationState {}
class NotificationLoadingMoreState extends NotificationState {
  NotificationLoadingMoreState(List<NotificationModels>? notifications)
      : super(
    notifications: notifications,
  );
}

class NotificationLoadMoreFailState extends NotificationState {
  NotificationLoadMoreFailState(List<NotificationModels>? notifications)
      : super(
    notifications: notifications,
  );
}
