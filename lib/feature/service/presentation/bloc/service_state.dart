part of 'bloc.dart';

class ServiceState {
  final PageStatus pageStatus;
  final ApiResponse? apiResponse;
  final int? selectedServiceId;


  ServiceState({
    this.pageStatus = const Initial(),
    this.apiResponse,
    this.selectedServiceId
  });

  ServiceState copyWith({
    PageStatus? pageStatus,
    ApiResponse? apiResponse,
    int? selectedServiceId
  }) {
    return ServiceState(
      pageStatus: pageStatus ?? this.pageStatus,
      apiResponse: apiResponse ?? this.apiResponse,
      selectedServiceId: selectedServiceId ?? this.selectedServiceId,
    );
  }
}
