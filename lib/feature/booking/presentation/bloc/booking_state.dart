part of 'bloc.dart';

class BookingState {
  final PageStatus pageStatus;
  final ApiResponse? apiResponse;
  final List<ProcessedBooking> processedBookingList;
  final bool isExpanded;
  final DateTime? selectedDay;
  final DateTime? focusedDay;
  final BookingCreateResponse? bookingCreateResponse;
  final DatamModel? cancelBookingResponse;


  BookingState({
    this.pageStatus = const Initial(),
    this.apiResponse,
    this.processedBookingList=const [],
    this.isExpanded = false,
    this.selectedDay,
    this.focusedDay,
    this.bookingCreateResponse,
    this.cancelBookingResponse
  });

  BookingState copyWith({
    PageStatus? pageStatus,
    ApiResponse? apiResponse,
    List<ProcessedBooking>? processedBookingList,
    bool? isExpanded,
    DateTime? selectedDay,
    DateTime? focusedDay,
    BookingCreateResponse? bookingCreateResponse,
    DatamModel? cancelBookingResponse
  }) {
    return BookingState(
      pageStatus: pageStatus ?? this.pageStatus,
      apiResponse: apiResponse ?? this.apiResponse,
      processedBookingList: processedBookingList ?? this.processedBookingList,
      isExpanded: isExpanded ?? this.isExpanded,
      selectedDay: selectedDay ?? this.selectedDay,
      focusedDay: focusedDay ?? this.focusedDay,
      bookingCreateResponse: bookingCreateResponse ?? this.bookingCreateResponse,
      cancelBookingResponse: cancelBookingResponse ?? this.cancelBookingResponse,
    );
  }
}
