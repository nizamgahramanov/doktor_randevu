part of 'bloc.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetTokenEvent extends LoginEvent {
  final LoginForm loginForm;
  GetTokenEvent({required this.loginForm});
}

class GetProviderEvent extends LoginEvent {}
class ChangePasswordVisibilityEvent extends LoginEvent {
  final bool passwordVisibility;
  ChangePasswordVisibilityEvent({required this.passwordVisibility});
}
