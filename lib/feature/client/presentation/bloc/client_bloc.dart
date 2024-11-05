part of 'bloc.dart';

class ClientBloc extends Bloc<ClientEvent, ClientState> {
  final ClientFetching clientFetching;
  final ClientCreating clientCreating;
  ClientBloc({required this.clientFetching, required this.clientCreating}) : super(ClientState()) {
    on<LoadClientEvent>(_loadClient);
    on<ClientSelectedEvent>(_clientSelected);
    on<CreateClientEvent>(_createClient);
  }

  Future<void> _loadClient(LoadClientEvent event, emit) async {
    print("_loadClient client");
    try {
      String? providerEmail = await LocalStorage.getProviderEmail();
      final apiResponse = await clientFetching.call(ClientFetchingParams(
        doctorEmail: providerEmail,
      ));
      apiResponse.fold(
          (failure) => emit(
                state.copyWith(
                  pageStatus: DataLoadFailed(),
                ),
              ), (apiResponse) {
        return emit(
          state.copyWith(
            pageStatus: DataLoaded(),
            apiResponse: apiResponse,
          ),
        );
      });
    } on Error {
      print("ERROR in bloc");
    }
  }

  FutureOr<void> _clientSelected(ClientSelectedEvent event, emit) {
    emit(state.copyWith(
      selectedClientId: event.clientId,
    ));
  }

  FutureOr<void> _createClient(CreateClientEvent event, Emitter<ClientState> emit) async {
   print("create client");
    try {

      final clientModel = await clientCreating.call(ClientCreatingParams(clientModel: event.newClientModel));
      clientModel.fold(
          (failure) => emit(
                state.copyWith(
                  pageStatus: DataSubmitFailed(),
                ),
              ), (clientModel) async {
        emit(
          state.copyWith(createdClientModel: clientModel.data),
        );
      });
    } on Error {
      print("Error in bloc happened");
    }
  }
}
