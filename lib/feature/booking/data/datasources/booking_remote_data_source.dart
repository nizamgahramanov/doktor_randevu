

import 'package:doktor_randevu/core/network/api_client.dart';
import 'package:doktor_randevu/feature/booking/data/models/booking_creation_response_model.dart';
import 'package:doktor_randevu/feature/booking/data/models/main_model.dart';
import 'package:doktor_randevu/feature/booking/domain/usecases/create_booking.dart';
import 'package:doktor_randevu/feature/booking/domain/usecases/load_booking.dart';
import 'package:doktor_randevu/feature/booking/domain/usecases/send_push_notification.dart';

import '../../../../core/network/api_response.dart';
import '../../../../core/network/urls.dart';
import '../models/datam_model.dart';

abstract class BookingRemoteDataSource {
  Future<ApiResponse> getBooking(BookingParams params);
  Future<ApiResponse> createBooking(CreatingBookingParams params);
  Future<void> sendPushNotification(SendPushNotificationParams params);
}

class BookingRemoteDataSourceImpl implements BookingRemoteDataSource {
  @override
  Future<ApiResponse> getBooking(BookingParams params) async {
    final Map<String, dynamic> queryParams = {
      'filter[upcoming_only]': params.upcomingOnly ? 1 : 0,
      if (params.chosenDate != null) 'filter[date]': params.chosenDate,
    };
    final ApiResponse response = await ApiClient().getRequest(Urls.bookingList,
        fromJson: (json) => MainModel<DatamModel>.fromJson(
              json,
              (itemJson) => DatamModel.fromJson(itemJson),
            ),
        parameters: queryParams);
    return response;
  }

  @override
  Future<ApiResponse> createBooking(CreatingBookingParams params) async {
    final Map<String, dynamic> queryParams = {
      'count': 1,
      'provider_id': params.conclusion!.providerId,
      'start_datetime': params.conclusion!.startDateTime,
      'service_id': params.conclusion!.serviceId,
      'client_id': params.conclusion!.clientId,
    };
    final ApiResponse? response = await ApiClient().postRequest(
      Urls.bookingList,
      fromJson: (data) => BookingCreateResponse.fromJson(data),
      parameters: queryParams,
    );
    return response!;
  }

  @override
  Future<void> sendPushNotification(SendPushNotificationParams params) async {
    await ApiClient().sendPushNotification(
      params.heading,
      params.message,
      params.userId
    );
  }
}
