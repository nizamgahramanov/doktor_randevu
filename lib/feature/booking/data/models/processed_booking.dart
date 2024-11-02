

import 'package:doktor_randevu/feature/booking/data/models/booking_date_info.dart';
import 'package:doktor_randevu/feature/booking/data/models/booking_info.dart';

class ProcessedBooking{
  BookingDateInfo bookingDateInfo;
  List<BookingInfo> bookingInfo;

  ProcessedBooking({
    required this.bookingDateInfo,
    required this.bookingInfo,
  });
}