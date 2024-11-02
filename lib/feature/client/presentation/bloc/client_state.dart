part of 'bloc.dart';

class ClientState {
  final PageStatus pageStatus;
  final ApiResponse? apiResponse;
  final int? selectedClientId;
  final ClientModel? createdClientModel;

  ClientState({
    this.pageStatus = const Initial(),
    this.apiResponse,
    this.selectedClientId,
    this.createdClientModel
  });

  ClientState copyWith({
    PageStatus? pageStatus,
    ApiResponse? apiResponse,
    int? selectedClientId,
    ClientModel? createdClientModel
  }) {
    return ClientState(
      pageStatus: pageStatus ?? this.pageStatus,
      apiResponse: apiResponse ?? this.apiResponse,
      selectedClientId: selectedClientId ?? this.selectedClientId,
      createdClientModel: createdClientModel ?? this.createdClientModel,
    );
  }
}
