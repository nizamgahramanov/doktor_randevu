class BookingDateInfo {
  String rowDate;
  String weekday;
  String? additionInfo;

  BookingDateInfo({
    required this.rowDate,
    required this.weekday,
    this.additionInfo,
  });
}
