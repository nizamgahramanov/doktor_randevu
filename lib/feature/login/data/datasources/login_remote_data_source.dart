import 'package:doktor_randevu/core/network/api_client.dart';
import 'package:doktor_randevu/core/usecase/usecase.dart';
import 'package:doktor_randevu/feature/booking/data/models/main_model.dart';
import 'package:doktor_randevu/feature/booking/data/models/provider_model.dart';
import 'package:doktor_randevu/feature/login/data/models/login_model.dart';
import 'package:doktor_randevu/feature/login/domain/usecases/token_fetching.dart';

import '../../../../core/network/api_response.dart';
import '../../../../core/network/urls.dart';

abstract class LoginRemoteDataSource {
  Future<ApiResponse> getToken(LoginParams params);
  Future<ApiResponse> getProvider(NoParams params);
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  @override
  Future<ApiResponse> getToken(LoginParams params) async {
    final Map<String, dynamic> parameters = params.toJson();

    final ApiResponse? response = await ApiClient().postRequest(
      Urls.login,
      parameters: parameters,
      fromJson: (json) => LoginModel.fromJson(json),
    );
    return response!;
  }

  @override
  Future<ApiResponse> getProvider(NoParams params) async {
    final ApiResponse response = await ApiClient().getRequest(
      Urls.providerList,
      fromJson: (json) => MainModel<ProviderModel>.fromJson(
        json,
            (itemJson) => ProviderModel.fromJson(itemJson),
      ),
    );
    return response;

  }

}
