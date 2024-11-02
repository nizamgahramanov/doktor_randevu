import '../../domain/entities/metadata_entity.dart';

class MetadataModel extends MetadataEntity {
  MetadataModel({
    required super.itemsCount,
    required super.pagesCount,
    required super.page,
    required super.onPage,
  });

  factory MetadataModel.fromJson(Map<String, dynamic> json) {
    return MetadataModel(
      itemsCount: json['items_count'],
      pagesCount: json['pages_count'],
      page: json['page'],
      onPage: json['on_page'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'itemsCount': itemsCount,
      'pagesCount': pagesCount,
      'page': page,
      'onPage': onPage,
    };
  }
}
