import 'package:dartz/dartz.dart';
import 'package:doktor_randevu/core/error/exception.dart';
import 'package:doktor_randevu/core/network/api_response.dart';
import 'package:doktor_randevu/core/usecase/usecase.dart';
import 'package:doktor_randevu/feature/booking/data/models/conclusion.dart';
import 'package:doktor_randevu/feature/booking/domain/repositories/booking_repository.dart';


class CreateBooking extends UseCase<ApiResponse, CreatingBookingParams> {
  final BookingRepository bookingRepository;
  CreateBooking({required this.bookingRepository});

  @override
  Future<Either<AppException, ApiResponse>> call(CreatingBookingParams params) async {
    return await bookingRepository.createBooking(params);
  }
}

class CreatingBookingParams {
  final Conclusion? conclusion;

  CreatingBookingParams({required this.conclusion});
}