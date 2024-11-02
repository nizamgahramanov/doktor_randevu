import 'package:dartz/dartz.dart';
import 'package:doktor_randevu/feature/client/data/models/client_model.dart';
import 'package:doktor_randevu/feature/client/domain/repositories/client_repository.dart';


import '../../../../core/error/exception.dart';
import '../../../../core/network/api_response.dart';
import '../../../../core/usecase/usecase.dart';

class ClientCreating extends UseCase<ApiResponse, ClientCreatingParams> {
  final ClientRepository clientRepository;
  ClientCreating({required this.clientRepository});

  @override
  Future<Either<AppException, ApiResponse>> call(ClientCreatingParams params) async {
    return await clientRepository.createClient(params);
  }
}

class ClientCreatingParams {
  final ClientModel clientModel;

  ClientCreatingParams({required this.clientModel});
}
