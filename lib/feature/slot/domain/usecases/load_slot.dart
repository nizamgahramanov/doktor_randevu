import 'package:dartz/dartz.dart';
import 'package:doktor_randevu/core/network/api_response.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/slot_repository.dart';

class LoadSlot extends UseCase<ApiResponse, SlotParams> {
  final SlotRepository slotRepository;
  LoadSlot({required this.slotRepository});

  @override
  Future<Either<AppException, ApiResponse>> call(SlotParams params) async {
    return await slotRepository.getSlot(params);
  }
}

class SlotParams {
  final String? chosenDate;
  final int serviceId;
  final int providerId;

  SlotParams({required this.chosenDate, required this.serviceId,required this.providerId});
}
