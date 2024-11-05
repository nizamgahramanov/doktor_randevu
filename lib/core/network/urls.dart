abstract class Urls {
  static const String baseUrl = 'https://user-api-v2.simplybook.me';

  static const String login = '$baseUrl/admin/auth';
  static const String appointment = '$baseUrl/app';
  static const String providerList = '$baseUrl/admin/providers';
  static const String clients = '$baseUrl/admin/clients';
  static const String service = '$baseUrl/admin/services';
  static const String booking =  '$baseUrl/admin/bookings';
  static const String slotList = '$baseUrl/admin/schedule/available-slots';
  static const String refreshToken = '$baseUrl/admin/auth/refresh-token';
}