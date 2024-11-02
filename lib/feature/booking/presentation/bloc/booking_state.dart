part of 'bloc.dart';

class BookingState {
  final PageStatus pageStatus;
  final ApiResponse? apiResponse;
  final List<ProcessedBooking> processedBookingList;
  final bool isExpanded;
  final DateTime? selectedDay;
  final DateTime? focusedDay;
  final BookingCreateResponse? bookingCreateResponse;


  BookingState({
    this.pageStatus = const Initial(),
    this.apiResponse,
    this.processedBookingList=const [],
    this.isExpanded = false,
    this.selectedDay,
    this.focusedDay,
    this.bookingCreateResponse
  });

  BookingState copyWith({
    PageStatus? pageStatus,
    ApiResponse? apiResponse,
    List<ProcessedBooking>? processedBookingList,
    bool? isExpanded,
    DateTime? selectedDay,
    DateTime? focusedDay,
    BookingCreateResponse? bookingCreateResponse
  }) {
    return BookingState(
      pageStatus: pageStatus ?? this.pageStatus,
      apiResponse: apiResponse ?? this.apiResponse,
      processedBookingList: processedBookingList ?? this.processedBookingList,
      isExpanded: isExpanded ?? this.isExpanded,
      selectedDay: selectedDay ?? this.selectedDay,
      focusedDay: focusedDay ?? this.focusedDay,
      bookingCreateResponse: bookingCreateResponse ?? this.bookingCreateResponse,
    );
  }
}
