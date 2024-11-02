import 'package:doktor_randevu/feature/slot/domain/entities/slot_entity.dart';

class SlotModel extends SlotEntity {
  SlotModel({
    required super.id,
    required super.date,
    required super.time,

  });

  factory SlotModel.fromJson(Map<String, dynamic> json) {
    return SlotModel(
      id: json['id'],
      date: json['date'],
      time: json['time'],
    );
  }

  // Method to convert SlotModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'time': time,
    };
  }
}
