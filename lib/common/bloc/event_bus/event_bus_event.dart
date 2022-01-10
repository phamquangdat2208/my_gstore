
abstract class EventBusEvent {}

class EventBusCheckCallEvent extends EventBusEvent {}

class EventBusShowCallEvent extends EventBusEvent {}

class EventBusRequestInitDataCartEvent extends EventBusEvent {}

class EventBusRequestInitDataNotificationEvent extends EventBusEvent {
  int? count;
  EventBusRequestInitDataNotificationEvent({this.count});
}

class EventBusRequestInitDataPersonalEvent extends EventBusEvent {}
