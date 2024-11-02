import '../../domain/entities/service_entity.dart';

class ServiceModel extends ServiceEntity {
  ServiceModel({
    required super.id,
    required super.name,
    required super.description,
    required super.price,
    required super.currency,
    required super.taxId,
    required super.tax,
    required super.duration,
    required super.bufferTimeAfter,
    required super.recurringSettings,
    required super.picture,
    required super.picturePreview,
    required super.memberships,
    required super.providers,
    required super.isActive,
    required super.isVisible,
    required super.durationType,
    required super.limitBooking,
    required super.minGroupBooking,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      currency: json['currency'],
      taxId: json['taxId'],
      tax: json['tax'],
      duration: json['duration'],
      bufferTimeAfter: json['buffer_time_after'],
      recurringSettings: json['recurring_settings'],
      picture: json['picture'],
      picturePreview: json['picture_preview'],
      memberships: List<dynamic>.from(json['memberships']),
      providers: List<int>.from(json['providers']),
      isActive: json['is_active'],
      isVisible: json['is_active'],
      durationType: json['duration_type'],
      limitBooking: json['limit_booking'],
      minGroupBooking: json['min_group_booking'],
    );
  }

  // Method to convert ServiceModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'currency': currency,
      'taxId': taxId,
      'tax': tax,
      'duration': duration,
      'bufferTimeAfter': bufferTimeAfter,
      'recurringSettings': recurringSettings,
      'picture': picture,
      'picturePreview': picturePreview,
      'memberships': memberships,
      'providers': providers,
      'isActive': isActive,
      'isVisible': isVisible,
      'durationType': durationType,
      'limitBooking': limitBooking,
      'minGroupBooking': minGroupBooking,
    };
  }
}
