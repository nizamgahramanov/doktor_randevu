part of 'bloc.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  final LoadService loadService;

  ServiceBloc({required this.loadService}) : super(ServiceState()) {
    on<LoadServiceEvent>(_loadService);
    on<ServiceSelectedEvent>(_serviceSelected);
  }

  Future<void> _loadService(LoadServiceEvent event, emit) async {
    try {
      final apiResponse = await loadService.call(ServiceParams(upcomingOnly: true, chosenDate: event.chosenDate));
      apiResponse.fold(
        (failure) => emit(
          state.copyWith(
            pageStatus: DataLoadFailed(),
          ),
        ),
        (apiResponse) => emit(
          state.copyWith(pageStatus: DataLoaded(), apiResponse: apiResponse),
        ),
      );
    } on Error {
      print("ERROR in bloc");
    }
  }

  FutureOr<void> _serviceSelected(ServiceSelectedEvent event, Emitter<ServiceState> emit) {
    emit(state.copyWith(selectedServiceId: event.serviceId));
  }
}
