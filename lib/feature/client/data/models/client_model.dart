import '../../domain/entities/client_entity.dart';

class ClientModel extends ClientEntity {
  ClientModel({
    super.canBeEdited,
    super.isDeleted,
    super.id,
    required super.name,
    required super.email,
    required super.phone,
    super.address1,
    super.address2,
    super.city,
    super.zip,
    super.countryId,
    super.stateId,
    super.fullAddress,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      canBeEdited: json['can_be_edited'],
      isDeleted: json['is_deleted'],
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      address1: json['address1'],
      address2: json['address2'],
      city: json['city'],
      zip: json['zip'],
      countryId: json['country_id'],
      stateId: json['state_id'],
      fullAddress: json['full_address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'canBeEdited': canBeEdited,
      'isDeleted': isDeleted,
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'address1': address1,
      'address2': address2,
      'city': city,
      'zip': zip,
      'countryId': countryId,
      'stateId': stateId,
      'fullAddress': fullAddress,
    };
  }
}