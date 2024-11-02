


import 'package:doktor_randevu/feature/booking/data/models/metadata_model.dart';
import 'package:doktor_randevu/feature/booking/domain/entities/main_entity.dart';

class MainModel<T> extends MainEntity<T> {
  MainModel({
    required super.data,
    required super.metadata,
  }) ;

  // Add the fromJson factory for parsing
  factory MainModel.fromJson(
      Map<String, dynamic> json,
      T Function(dynamic) fromJsonT, // A function to convert json data to T
      ) {
    return MainModel<T>(
      data: List<T>.from(json['data'].map((item) => fromJsonT(item))),
      metadata: MetadataModel.fromJson(json['metadata']),
    );
  }
}

/*  class MainModel extends MainEntity {
  MainModel({
    required super.data,
    required super.metadata,
  });
  factory MainModel.fromJson(
      Map<String, dynamic> json,) {
    return MainModel(
      data: List.from(json['data'].map((item) => fromJsonT(item))),
      metadata: MetadataModel.fromJson(json['metadata']),
    );
  }
 factory MainModel.fromJson(Map<String, dynamic> json) {
    return MainModel(
      data: List<DatamModel>.from(
          json["data"].map((x) => DatamModel.fromJson(x))),
      metadata: MetadataModel.fromJson(json['metadata']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data,
      'metadata': metadata,
    };
  }
}*/