part of 'bloc.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final LoadBooking loadBooking;
  final CreateBooking bookCreating;
  final SendPushNotification sendPushNotification;
  final CancelBooking cancelBooking;
  BookingBloc({required this.loadBooking, required this.bookCreating, required this.sendPushNotification, required this.cancelBooking}) : super(BookingState()) {
    on<LoadBookingEvent>(_loadBooking);
    on<ToggleCalendarEvent>(_toggleCalendar);
    on<DaySelectedEvent>(_daySelected);
    on<CreateBookEvent>(_createBook);
    on<SendPushNotificationEvent>(_sendPushNotification);
  }

  Future<void> _loadBooking(LoadBookingEvent event, emit) async {
    try {
      final apiResponse = await loadBooking.call(BookingParams(upcomingOnly: event.upcomingOnly, chosenDate: event.chosenDate));
      apiResponse.fold(
        (failure) => emit(
          state.copyWith(
            pageStatus: DataLoadFailed(),
          ),
        ),
        (apiResponse) => emit(
          state.copyWith(pageStatus: DataLoaded(), apiResponse: apiResponse, processedBookingList: processApiResponse(apiResponse)),
        ),
      );
    } on Error {
      print("Error occur in Booking Bloc");
    }
  }

  List<ProcessedBooking> processApiResponse(ApiResponse apiResponse) {
    List<ProcessedBooking> processedBookingList = [];
    if (apiResponse.data != null && apiResponse.data is MainModel) {
      Map<String, List<BookingInfo>> groupedBookings = {};

      for (var booking in apiResponse.data.data) {
        String startDatetime = booking.startDatetime;
        DateTime parsedStartDatetime = DateTime.parse(startDatetime);
        DateTime endDatetime = parsedStartDatetime.add(const Duration(hours: 1));
        String formattedDate = DateFormat('yyyy-MM-dd').format(parsedStartDatetime);
        String formattedStartTime = DateFormat('HH:mm').format(parsedStartDatetime);
        String formattedEndTime = DateFormat('HH:mm').format(endDatetime);
        BookingInfo bookingInfo = BookingInfo(
          id: booking.id,
          clientName: booking.client?.name,
          clientPhone: booking.client?.phone,
          clientNote: booking.client?.address1,
          status: booking.status,
          timeStart: formattedStartTime,
          timeEnd: formattedEndTime,
          date: formattedDate,
          serviceName: booking.service.name,
          serviceDuration: booking.duration.toString(),
        );
        if (groupedBookings.containsKey(formattedDate)) {
          groupedBookings[formattedDate]!.add(bookingInfo);
        } else {
          groupedBookings[formattedDate] = [bookingInfo];
        }
      }

      processedBookingList = groupedBookings.entries.map((entry) {
        String date = entry.key;
        List<BookingInfo> bookingsForDate = entry.value;

        String weekday = DateFormat('EEEE').format(DateTime.parse(date));
        BookingDateInfo bookingDateInfo = BookingDateInfo(
          rowDate: date,
          weekday: weekday,
          additionInfo: 'Additional info',
        );
        return ProcessedBooking(
          bookingDateInfo: bookingDateInfo,
          bookingInfo: bookingsForDate,
        );
      }).toList();
    }
    return processedBookingList;
  }

  FutureOr<void> _toggleCalendar(ToggleCalendarEvent event, Emitter<BookingState> emit) {
    emit(state.copyWith(isExpanded: event.isExpanded));
  }

  FutureOr<void> _daySelected(DaySelectedEvent event, Emitter<BookingState> emit) async {
    emit(state.copyWith(selectedDay: event.selectedDay, focusedDay: event.focusedDay));
    await _loadBooking(LoadBookingEvent(chosenDate: DateFormat('yyyy-MM-dd').format(event.selectedDay), upcomingOnly: false), emit);
  }

  FutureOr<void> _createBook(CreateBookEvent event, Emitter<BookingState> emit) async {
    try {
      final apiResponse = await bookCreating.call(CreatingBookingParams(conclusion: event.conclusion));
      apiResponse.fold(
        (failure) => emit(
          state.copyWith(
            pageStatus: DataSubmitFailed(),
          ),
        ),
        (apiResponse) => emit(
          state.copyWith(pageStatus: DataSubmitted(), bookingCreateResponse: apiResponse.data),
        ),
      );
    } on Error {
      print("ERROR in bloc");
    }
  }

  FutureOr<void> _sendPushNotification(SendPushNotificationEvent event, Emitter<BookingState> emit) async {

    await sendPushNotification.call(SendPushNotificationParams(
      message: formattedMessage(event.conclusion),
      userId: event.conclusion.providerId.toString(),
      heading: event.heading
    ));
  }

  formattedMessage(Conclusion conclusion) {
    return '${conclusion.clientName} ${conclusion.date}, ${conclusion.startTime} tarixinə yazıldı.';
  }
}
