import 'package:doktor_randevu/core/network/api_client.dart';
import 'package:doktor_randevu/feature/slot/data/models/slot_model.dart';
import 'package:doktor_randevu/feature/slot/domain/usecases/load_slot.dart';
import 'package:intl/intl.dart';

import '../../../../core/network/api_response.dart';
import '../../../../core/network/urls.dart';

abstract class SlotRemoteDataSource {
  Future<ApiResponse> getSlot(SlotParams params);
}

class SlotRemoteDataSourceImpl implements SlotRemoteDataSource {
  @override
  Future<ApiResponse> getSlot(SlotParams params) async {
    final Map<String, dynamic> queryParams = {
      'date': params.chosenDate??DateFormat('yyyy-MM-dd').format(DateTime.now()),
      'provider_id':params.providerId,
      'service_id':params.serviceId,
    };
    final ApiResponse response = await ApiClient().getRequest(
      Urls.slotList,
      fromJson: (json) {
        return (json as List)
            .map((slotJson) => SlotModel.fromJson(slotJson))
            .toList();
      },
      parameters: queryParams,
    );
    print((response.data as List<SlotModel>).toString());
    return response;
  }
}
