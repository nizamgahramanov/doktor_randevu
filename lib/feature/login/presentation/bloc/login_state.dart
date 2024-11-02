part of 'bloc.dart';

class LoginState {
  final PageStatus pageStatus;
  final ApiResponse? apiResponse;
  final ProviderModel? providerModel;
  final bool isPasswordVisible;


  LoginState({
    this.pageStatus = const Initial(),
    this.apiResponse,
    this.providerModel,
    this.isPasswordVisible=true,
  });

  LoginState copyWith({
    PageStatus? pageStatus,
    ApiResponse? apiResponse,
    ProviderModel? providerModel,
    bool? isPasswordVisible,
  }) {
    return LoginState(
      pageStatus: pageStatus ?? this.pageStatus,
      apiResponse: apiResponse ?? this.apiResponse,
      providerModel: providerModel ?? this.providerModel,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
    );
  }
}
