import 'package:dartz/dartz.dart';
import 'package:doktor_randevu/feature/slot/domain/usecases/load_slot.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/network/api_response.dart';

abstract class SlotRepository {
  Future<Either<AppException, ApiResponse>> getSlot(SlotParams params);
}
