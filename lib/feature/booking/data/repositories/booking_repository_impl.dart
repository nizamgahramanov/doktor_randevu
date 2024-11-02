import 'package:dartz/dartz.dart';
import 'package:doktor_randevu/feature/booking/domain/usecases/create_booking.dart';
import 'package:doktor_randevu/feature/booking/domain/usecases/load_booking.dart';
import 'package:doktor_randevu/feature/booking/domain/usecases/send_push_notification.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/network/api_response.dart';
import '../../domain/repositories/booking_repository.dart';
import '../datasources/booking_remote_data_source.dart';

class BookingRepositoryImpl extends BookingRepository {
  final BookingRemoteDataSource bookingRemoteDataSource;

  BookingRepositoryImpl({required this.bookingRemoteDataSource});

  @override
  Future<Either<AppException, ApiResponse>> getBooking(BookingParams params) async {
    try {
      final result = await bookingRemoteDataSource.getBooking(params);
      return Right(result);
    } on AppException {
      return Left(AppException("Something else"));
    }
  }

  @override
  Future<Either<AppException, ApiResponse>> createBooking(CreatingBookingParams params) async {
    try {
      final result = await bookingRemoteDataSource.createBooking(params);
      return Right(result);
    } on AppException {
      return Left(AppException("Something else"));
    }
  }

  @override
  Future<Either<AppException, ApiResponse>> sendPushNotification(SendPushNotificationParams params) async {
    try {
       await bookingRemoteDataSource.sendPushNotification(params);
      return Right(ApiResponse(status: ApiResult.Success));
    } on AppException {
      return Left(AppException("Something else"));
    }
  }
}
