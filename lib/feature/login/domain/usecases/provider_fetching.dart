import 'package:dartz/dartz.dart';
import 'package:doktor_randevu/core/network/api_response.dart';
import 'package:doktor_randevu/feature/login/domain/repositories/login_repository.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/usecase/usecase.dart';

class ProviderFetching extends UseCase<ApiResponse, NoParams> {
  final LoginRepository loginRepository;
  ProviderFetching({required this.loginRepository});

  @override
  Future<Either<AppException, ApiResponse>> call(NoParams params) async {
    return await loginRepository.getProvider(params);
  }
}

class ProviderParams {
  final String? chosenDate;
  final bool upcomingOnly;

  ProviderParams({this.chosenDate, required this.upcomingOnly});
}
