import 'package:dartz/dartz.dart';
import 'package:doktor_randevu/feature/client/data/datasources/client_remote_data_source.dart';
import 'package:doktor_randevu/feature/client/domain/repositories/client_repository.dart';
import 'package:doktor_randevu/feature/client/domain/usecases/client_fetching.dart';


import '../../../../core/error/exception.dart';
import '../../../../core/network/api_response.dart';
import '../../domain/usecases/client_creating.dart';

class ClientRepositoryImpl extends ClientRepository {
  final ClientRemoteDataSource clientRemoteDataSource;

  ClientRepositoryImpl({required this.clientRemoteDataSource});

  @override
  Future<Either<AppException, ApiResponse>> getClient(ClientFetchingParams params) async {
    try {
      final result = await clientRemoteDataSource.getClient(params);
      return Right(result);
    } on AppException {
      return Left(AppException("Something else"));
    }
  }
  @override
  Future<Either<AppException, ApiResponse>> createClient(ClientCreatingParams params) async {
    try {
      final result = await clientRemoteDataSource.createClient(params);
      return Right(result);
    } on AppException {
      return Left(AppException("Something else"));
    }
  }
}
