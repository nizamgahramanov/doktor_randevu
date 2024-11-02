import 'package:dartz/dartz.dart';
import 'package:doktor_randevu/feature/slot/data/datasources/slot_remote_data_source.dart';
import 'package:doktor_randevu/feature/slot/domain/repositories/slot_repository.dart';
import 'package:doktor_randevu/feature/slot/domain/usecases/load_slot.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/network/api_response.dart';

class SlotRepositoryImpl extends SlotRepository {
  final SlotRemoteDataSource slotRemoteDataSource;

  SlotRepositoryImpl({required this.slotRemoteDataSource});

  @override
  Future<Either<AppException, ApiResponse>> getSlot(SlotParams params) async {
    try {
      final result = await slotRemoteDataSource.getSlot(params);
      return Right(result);
    } on AppException {
      return Left(AppException("Something else"));
    }
  }
}
