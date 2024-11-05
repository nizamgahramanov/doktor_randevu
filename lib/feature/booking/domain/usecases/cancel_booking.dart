import 'package:dartz/dartz.dart';
import 'package:doktor_randevu/core/error/exception.dart';
import 'package:doktor_randevu/core/network/api_response.dart';
import 'package:doktor_randevu/core/usecase/usecase.dart';
import 'package:doktor_randevu/feature/booking/domain/repositories/booking_repository.dart';


class CancelBooking extends UseCase<ApiResponse, CancelBookingParams> {
  final BookingRepository bookingRepository;
  CancelBooking({required this.bookingRepository});

  @override
  Future<Either<AppException, ApiResponse>> call(CancelBookingParams params) async {
    return await bookingRepository.cancelBooking(params);
  }
}

class CancelBookingParams {
  final int? id;
  CancelBookingParams({required this.id});
}