part of 'bloc.dart';

abstract class BookingEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadBookingEvent extends BookingEvent {
  final String? chosenDate;
  final bool upcomingOnly;
  LoadBookingEvent({this.chosenDate, required this.upcomingOnly});
}

class ToggleCalendarEvent extends BookingEvent {
  final bool isExpanded;

  ToggleCalendarEvent({required this.isExpanded});
}

class DaySelectedEvent extends BookingEvent {
  final DateTime selectedDay;
  final DateTime focusedDay;

  DaySelectedEvent({required this.selectedDay, required this.focusedDay});
}

class CreateBookEvent extends BookingEvent {
  final Conclusion conclusion;

  CreateBookEvent({required this.conclusion});
}

class SendPushNotificationEvent extends BookingEvent {
  final Conclusion conclusion;
  final String heading;
  SendPushNotificationEvent({
    required this.conclusion,
    required this.heading,
  });
}
