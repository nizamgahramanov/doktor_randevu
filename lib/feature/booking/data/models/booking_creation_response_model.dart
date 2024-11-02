class BookingCreateResponse {
  final int id;
  final String code;
  final DateTime startDatetime;
  final DateTime endDatetime;
  final int? locationId;
  final int? categoryId;
  final int? serviceId;
  final int? providerId;
  final int? clientId;
  final int? duration;

  BookingCreateResponse({
    required this.id,
    required this.code,
    required this.startDatetime,
    required this.endDatetime,
    this.locationId,
    this.categoryId,
    required this.serviceId,
    required this.providerId,
    required this.clientId,
    this.duration,
  });

  factory BookingCreateResponse.fromJson(Map<String, dynamic> json) {
    return BookingCreateResponse(
      id: json['id'],
      code: json['code'],
      startDatetime: DateTime.parse(json['start_datetime']),
      endDatetime: DateTime.parse(json['end_datetime']),
      locationId: json['location_id'],
      categoryId: json['category_id'],
      serviceId: json['service_id'],
      providerId: json['provider_id'],
      clientId: json['client_id'],
      duration: json['duration'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'start_datetime': startDatetime.toIso8601String(),
      'end_datetime': endDatetime.toIso8601String(),
      'location_id': locationId,
      'category_id': categoryId,
      'service_id': serviceId,
      'provider_id': providerId,
      'client_id': clientId,
      'duration': duration,
    };
  }
}
