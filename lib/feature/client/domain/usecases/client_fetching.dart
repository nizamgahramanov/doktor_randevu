import 'package:dartz/dartz.dart';
import 'package:doktor_randevu/core/network/api_response.dart';
import 'package:doktor_randevu/feature/client/domain/repositories/client_repository.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/usecase/usecase.dart';

class ClientFetching extends UseCase<ApiResponse, ClientFetchingParams> {
  final ClientRepository clientRepository;
  ClientFetching({required this.clientRepository});

  @override
  Future<Either<AppException, ApiResponse>> call(ClientFetchingParams params) async {
    return await clientRepository.getClient(params);
  }
}

class ClientFetchingParams {
  final String? doctorEmail;

  ClientFetchingParams({required this.doctorEmail});
}
