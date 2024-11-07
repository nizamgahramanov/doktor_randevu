class Conclusion {
  int? bookingId;
  int? clientId;
  int? providerId;
  String? status;
  String? providerEmail;
  String? clientName;
  String? clientPhone;
  String? startDateTime;
  String? date;
  String? startTime;
  String? endTime;
  String? bookingDuration;
  int? serviceId;
  String? serviceName;
  String? serviceDuration;
  String? patientNote;
  String? bookNote;
  String title;
  bool isBookInfo;

  Conclusion({
    this.bookingId,
    this.clientId,
    this.providerId,
    this.status,
    this.providerEmail,
    this.clientName,
    this.clientPhone,
    this.startDateTime,
    this.date,
    this.startTime,
    this.endTime,
    this.bookingDuration,
    this.serviceId,
    this.serviceName,
    this.serviceDuration,
    this.patientNote,
    this.bookNote,
    required this.title,
    required this.isBookInfo,
  });
}
