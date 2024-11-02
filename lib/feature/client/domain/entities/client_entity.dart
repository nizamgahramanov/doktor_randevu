class ClientEntity {
  bool? canBeEdited;
  String? isDeleted;
  int? id;
  String name;
  String email;
  String phone;
  String? address1;
  String? address2;
  String? city;
  String? zip;
  String? countryId;
  String? stateId;
  String? fullAddress;

  ClientEntity({
    required this.canBeEdited,
    required this.isDeleted,
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address1,
    required this.address2,
    required this.city,
    required this.zip,
    required this.countryId,
    required this.stateId,
    required this.fullAddress,
  });
}