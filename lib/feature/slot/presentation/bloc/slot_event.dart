part of 'bloc.dart';

abstract class SlotEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadSlotEvent extends SlotEvent {
  final String? chosenDate;
  final int serviceId;
  final int providerId;
  LoadSlotEvent({this.chosenDate, required this.serviceId, required this.providerId});
}

class SlotSelectedEvent extends SlotEvent {
  final String slotId;

  SlotSelectedEvent({required this.slotId});
}

class ToggleCalendarEvent extends SlotEvent {
  final bool isExpanded;

  ToggleCalendarEvent({required this.isExpanded});
}

class DaySelectedEvent extends SlotEvent {
  final DateTime selectedDay;
  final DateTime focusedDay;
  final int serviceId;
  final int providerId;

  DaySelectedEvent({
    required this.selectedDay,
    required this.focusedDay,
    required this.serviceId,
    required this.providerId,
  });
}
