class BookingInfo {
  int id;
  String? clientName;
  String? clientPhone;
  String? clientNote;
  String status;
  String timeStart;
  String timeEnd;
  String date;
  String serviceName;
  String serviceDuration;


  BookingInfo({
    required this.id,
    this.clientName,
    this.clientPhone,
    this.clientNote,
    required this.status,
    required this.timeStart,
    required this.timeEnd,
    required this.date,
    required this.serviceName,
    required this.serviceDuration,
  });
}
