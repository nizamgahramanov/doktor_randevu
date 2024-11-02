part of 'bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final TokenFetching tokenFetching;
  final ProviderFetching providerFetching;

  LoginBloc({required this.tokenFetching, required this.providerFetching}) : super(LoginState()) {
    on<GetTokenEvent>(_getToken);
    on<GetProviderEvent>(_getProvider);
    on<ChangePasswordVisibilityEvent>(_changeVisibility);
  }

  Future<void> _getToken(GetTokenEvent event, emit) async {
    LocalStorage.setToken(null);
    try {
      emit(
        state.copyWith(pageStatus: DataLoading()),
      );
      final apiResponse = await tokenFetching.call(LoginParams(
        login: event.loginForm.email,
        password: event.loginForm.password,
        company: 'DoktorRandevu',
      ));
      apiResponse.fold(
        (failure) {
          emit(
            state.copyWith(pageStatus: DataSubmitFailed()),
          );
        },
        (apiResponse) {
          if (apiResponse.status == ApiResult.Success) {
            final loginModel = apiResponse.data as LoginModel;

            LocalStorage.setToken(loginModel.token);
            LocalStorage.setProviderEmail(loginModel.login);
            LocalStorage.setRefreshToken(loginModel.refreshToken);
            emit(
              state.copyWith(
                pageStatus: DataSubmitted(),
                apiResponse: apiResponse,
              ),
            );
            // add(GetProviderEvent());
          } else if (apiResponse.status == ApiResult.Error) {
            emit(
              state.copyWith(
                pageStatus: DataSubmitFailed(),
                apiResponse: apiResponse,
              ),
            );
          }
        },
      );
    } on Error {
      print("ERROR in bloc");
    }
  }

  FutureOr<void> _getProvider(GetProviderEvent event, Emitter<LoginState> emit) async {
    try {
      emit(state.copyWith(pageStatus: DataLoading()));

      final apiResponse = await providerFetching.call(NoParams());
      apiResponse.fold(
        (failure) => emit(
          state.copyWith(
            pageStatus: DataLoadFailed(),
          ),
        ),
        (apiResponse) async {
          if (apiResponse.status == ApiResult.Success) {
            final mainModel = apiResponse.data as MainModel<ProviderModel?>;
            emit(
              state.copyWith(
                pageStatus: DataLoaded(),
                providerModel: mainModel.data.first,
              ),
            );
            LocalStorage.setProviderId(mainModel.data.first!.id);
            await OneSignal.shared.setExternalUserId(mainModel.data.first!.id.toString());
          }
        },
      );
    } on Error {
      print("ERROR in bloc");
    }
  }

  FutureOr<void> _changeVisibility(ChangePasswordVisibilityEvent event, Emitter<LoginState> emit) {
    emit(
      state.copyWith(isPasswordVisible: event.passwordVisibility),
    );
  }
}
