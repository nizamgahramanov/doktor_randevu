import 'package:dartz/dartz.dart';
import 'package:doktor_randevu/feature/service/domain/usecases/load_service.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/network/api_response.dart';
import '../../domain/repositories/service_repository.dart';
import '../datasources/service_remote_data_source.dart';

class ServiceRepositoryImpl extends ServiceRepository {
  final ServiceRemoteDataSource serviceRemoteDataSource;

  ServiceRepositoryImpl({required this.serviceRemoteDataSource});

  @override
  Future<Either<AppException, ApiResponse>> getService(ServiceParams params) async {
    try {
      final result = await serviceRemoteDataSource.getService(params);
      return Right(result);
    } on AppException {
      return Left(AppException("Something else"));
    }
  }
}
