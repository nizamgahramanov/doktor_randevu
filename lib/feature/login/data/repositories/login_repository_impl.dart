import 'package:dartz/dartz.dart';
import 'package:doktor_randevu/core/usecase/usecase.dart';
import 'package:doktor_randevu/feature/login/data/datasources/login_remote_data_source.dart';
import 'package:doktor_randevu/feature/login/domain/repositories/login_repository.dart';
import 'package:doktor_randevu/feature/login/domain/usecases/token_fetching.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/network/api_response.dart';

class LoginRepositoryImpl extends LoginRepository {
  final LoginRemoteDataSource loginRemoteDataSource;

  LoginRepositoryImpl({required this.loginRemoteDataSource});

  @override
  Future<Either<AppException, ApiResponse>> getToken(LoginParams params) async {
    try {
      final result = await loginRemoteDataSource.getToken(params);
      return Right(result);
    } on AppException {
      return Left(AppException("Something else"));
    }
  }

  @override
  Future<Either<AppException, ApiResponse>> getProvider(NoParams params) async {
    try {
      final result = await loginRemoteDataSource.getProvider(params);
      return Right(result);
    } on AppException {
      return Left(AppException("Something else"));
    }
  }
}
