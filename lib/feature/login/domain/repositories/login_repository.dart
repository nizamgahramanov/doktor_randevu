import 'package:dartz/dartz.dart';
import 'package:doktor_randevu/core/usecase/usecase.dart';
import 'package:doktor_randevu/feature/login/domain/usecases/token_fetching.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/network/api_response.dart';

abstract class LoginRepository {
  Future<Either<AppException, ApiResponse>> getToken(LoginParams params);
  Future<Either<AppException, ApiResponse>> getProvider(NoParams params);
}
