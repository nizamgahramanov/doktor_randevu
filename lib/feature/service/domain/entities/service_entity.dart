class ServiceEntity {
  int id;
  String name;
  String? description;
  dynamic price;
  dynamic currency;
  dynamic taxId;
  dynamic tax;
  int duration;
  int? bufferTimeAfter;
  dynamic recurringSettings;
  dynamic picture;
  dynamic picturePreview;
  dynamic memberships;
  dynamic providers;
  bool? isActive;
  bool? isVisible;
  dynamic durationType;
  dynamic limitBooking;
  dynamic minGroupBooking;

  ServiceEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.currency,
    required this.taxId,
    required this.tax,
    required this.duration,
    required this.bufferTimeAfter,
    required this.recurringSettings,
    required this.picture,
    required this.picturePreview,
    required this.memberships,
    required this.providers,
    required this.isActive,
    required this.isVisible,
    required this.durationType,
    required this.limitBooking,
    required this.minGroupBooking,
  });

}