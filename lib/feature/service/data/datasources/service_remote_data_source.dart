import 'package:doktor_randevu/core/network/api_client.dart';
import 'package:doktor_randevu/feature/booking/data/models/main_model.dart';
import 'package:doktor_randevu/feature/service/data/models/service_model.dart';
import 'package:doktor_randevu/feature/service/domain/usecases/load_service.dart';

import '../../../../core/network/api_response.dart';
import '../../../../core/network/urls.dart';

abstract class ServiceRemoteDataSource {
  Future<ApiResponse> getService(ServiceParams params);
}

class ServiceRemoteDataSourceImpl implements ServiceRemoteDataSource {
  @override
  Future<ApiResponse> getService(ServiceParams params) async {
    final ApiResponse response = await ApiClient().getRequest(
      Urls.service,
      fromJson: (json) => MainModel<ServiceModel>.fromJson(
        json,
        (itemJson) => ServiceModel.fromJson(itemJson),
      ),
    );
    return response;
  }
}
