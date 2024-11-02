import 'package:dartz/dartz.dart';
import 'package:doktor_randevu/feature/client/domain/usecases/client_creating.dart';
import 'package:doktor_randevu/feature/client/domain/usecases/client_fetching.dart';


import '../../../../core/error/exception.dart';
import '../../../../core/network/api_response.dart';

abstract class ClientRepository {
  Future<Either<AppException, ApiResponse>> getClient(ClientFetchingParams params);
  Future<Either<AppException, ApiResponse>> createClient(ClientCreatingParams params);

}
