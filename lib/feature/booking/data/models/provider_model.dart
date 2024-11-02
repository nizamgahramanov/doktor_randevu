import '../../domain/entities/provider_entity.dart';

class ProviderModel extends ProviderEntity {
  ProviderModel({
    required super.id,
    required super.name,
    required super.qty,
    super.email,
    super.description,
    required super.phone,
    required super.picture,
    required super.picturePreview,
    required super.color,
    super.isActive,
    super.isVisible,
    required super.services,
  });

  factory ProviderModel.fromJson(Map<String, dynamic> json) {
    return ProviderModel(
      id: json['id'],
      name: json['name'],
      qty: json['qty'],
      email: json['email'],
      description: json['description'],
      phone: json['phone'],
      picture: json['picture'],
      picturePreview: json['picture_preview'],
      color: json['color'],
      isActive: json['is_active'],
      isVisible: json['is_visible'],
      services: List<String>.from(json['services']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'qty': qty,
      'email': email,
      'description': description,
      'phone': phone,
      'picture': picture,
      'picturePreview': picturePreview,
      'color': color,
      'isActive': isActive,
      'isVisible': isVisible,
      'services': services,
    };
  }
}
