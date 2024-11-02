

import 'package:doktor_randevu/core/network/api_client.dart';
import 'package:doktor_randevu/feature/booking/data/models/main_model.dart';
import 'package:doktor_randevu/feature/client/data/models/client_model.dart';
import 'package:doktor_randevu/feature/client/domain/usecases/client_creating.dart';
import 'package:doktor_randevu/feature/client/domain/usecases/client_fetching.dart';

import '../../../../core/network/api_response.dart';
import '../../../../core/network/urls.dart';

abstract class ClientRemoteDataSource {
  Future<ApiResponse> getClient(ClientFetchingParams params);
  Future<ApiResponse> createClient(ClientCreatingParams params);
}

class ClientRemoteDataSourceImpl implements ClientRemoteDataSource {
  @override
  Future<ApiResponse> getClient(ClientFetchingParams params) async {
    final Map<String, dynamic> queryParams = {
      'filter[search]':params.doctorEmail,
      'on_page':500
    };
    final ApiResponse response = await ApiClient().getRequest(
      Urls.clients,
      fromJson: (json) => MainModel<ClientModel>.fromJson(
        json,
            (itemJson) => ClientModel.fromJson(itemJson),
      ),
      parameters: queryParams,
    );
    return response;
  }

  @override
  Future<ApiResponse> createClient(ClientCreatingParams params) async {
    final Map<String, dynamic> queryParams = params.clientModel.toJson();
    final ApiResponse? response = await ApiClient().postRequest(
      Urls.clients,
      fromJson: (data) => ClientModel.fromJson(data),
      parameters: queryParams,
    );
    return response!;
  }
}
