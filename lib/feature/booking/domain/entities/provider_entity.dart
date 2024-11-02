class ProviderEntity {
  int id;
  String name;
  int qty;
  String? email;
  String? description;
  String phone;
  dynamic picture;
  dynamic picturePreview;
  dynamic color;
  bool? isActive;
  bool? isVisible;
  List<String> services;

  ProviderEntity({
    required this.id,
    required this.name,
    required this.qty,
    required this.email,
    required this.description,
    required this.phone,
    required this.picture,
    required this.picturePreview,
    required this.color,
    required this.isActive,
    required this.isVisible,
    required this.services,
  });
}