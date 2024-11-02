import 'package:dartz/dartz.dart';
import 'package:doktor_randevu/core/network/api_response.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/service_repository.dart';

class LoadService extends UseCase<ApiResponse, ServiceParams> {
  final ServiceRepository serviceRepository;
  LoadService({required this.serviceRepository});

  @override
  Future<Either<AppException, ApiResponse>> call(ServiceParams params) async {
    return await serviceRepository.getService(params);
  }
}

class ServiceParams {
  final String? chosenDate;
  final bool upcomingOnly;

  ServiceParams({this.chosenDate, required this.upcomingOnly});
}
