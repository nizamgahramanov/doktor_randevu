import 'package:dartz/dartz.dart';
import 'package:doktor_randevu/core/network/api_response.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/booking_repository.dart';

class LoadBooking extends UseCase<ApiResponse, BookingParams> {
  final BookingRepository bookingRepository;
  LoadBooking({required this.bookingRepository});

  @override
  Future<Either<AppException, ApiResponse>> call(BookingParams params) async {
    return await bookingRepository.getBooking(params);
  }
}

class BookingParams {
  final String? chosenDate;
  final bool upcomingOnly;

  BookingParams({this.chosenDate, required this.upcomingOnly});
}
