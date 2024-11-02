import 'package:dartz/dartz.dart';
import 'package:doktor_randevu/core/network/api_response.dart';
import 'package:doktor_randevu/feature/login/domain/repositories/login_repository.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/usecase/usecase.dart';

class TokenFetching extends UseCase<ApiResponse, LoginParams> {
  final LoginRepository loginRepository;
  TokenFetching({required this.loginRepository});

  @override
  Future<Either<AppException, ApiResponse>> call(LoginParams params) async {
    return await loginRepository.getToken(params);
  }
}

class LoginParams {
  final String login;
  final String password;
  final String company;

  LoginParams({
    required this.login,
    required this.password,
    required this.company,
  });
  Map<String, dynamic> toJson() {
    return {
      'login': login,
      'password': password,
      'company': company,
    };
  }
}
