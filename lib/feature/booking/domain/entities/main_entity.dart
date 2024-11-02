
import 'package:doktor_randevu/feature/booking/domain/entities/metadata_entity.dart';

class MainEntity<T> {
  List<T> data;
  MetadataEntity metadata;

  MainEntity({
    required this.data,
    required this.metadata,
  });
}
