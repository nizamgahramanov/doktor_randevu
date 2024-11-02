import 'package:dartz/dartz.dart';
import 'package:doktor_randevu/feature/service/domain/usecases/load_service.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/network/api_response.dart';

abstract class ServiceRepository {
  Future<Either<AppException, ApiResponse>> getService(ServiceParams params);
}
