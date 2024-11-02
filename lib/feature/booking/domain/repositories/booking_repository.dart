import 'package:dartz/dartz.dart';
import 'package:doktor_randevu/feature/booking/domain/usecases/create_booking.dart';
import 'package:doktor_randevu/feature/booking/domain/usecases/load_booking.dart';
import 'package:doktor_randevu/feature/booking/domain/usecases/send_push_notification.dart';


import '../../../../core/error/exception.dart';
import '../../../../core/network/api_response.dart';

abstract class BookingRepository {
  Future<Either<AppException, ApiResponse>> getBooking(BookingParams params);
  Future<Either<AppException, ApiResponse>> createBooking(CreatingBookingParams params);
  Future<Either<AppException, ApiResponse>> sendPushNotification(SendPushNotificationParams params);

}
