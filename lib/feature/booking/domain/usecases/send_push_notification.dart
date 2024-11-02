import 'package:dartz/dartz.dart';
import 'package:doktor_randevu/core/error/exception.dart';
import 'package:doktor_randevu/core/network/api_response.dart';
import 'package:doktor_randevu/core/usecase/usecase.dart';
import 'package:doktor_randevu/feature/booking/domain/repositories/booking_repository.dart';


class SendPushNotification extends UseCase<ApiResponse, SendPushNotificationParams> {
  final BookingRepository bookingRepository;
  SendPushNotification({required this.bookingRepository});

  @override
  Future<Either<AppException, ApiResponse>> call(SendPushNotificationParams params) async {
    return await bookingRepository.sendPushNotification(params);
  }
}

class SendPushNotificationParams {
  final String heading;
  final String message;
  final String userId;


  SendPushNotificationParams({
    required this.heading,
    required this.message,
    required this.userId,
  });
}
