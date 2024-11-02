
import 'package:doktor_randevu/feature/login/domain/entities/login_entity.dart';

class LoginModel extends LoginEntity {
  LoginModel({
    required super.token,
    required super.company,
    required super.login,
    required super.refreshToken,
    required super.domain,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      token: json['token'],
      company: json['company'],
      login: json['login'],
      refreshToken: json['refresh_token'],
      domain: json['domain'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'company': company,
      'login': login,
      'refreshToken': refreshToken,
      'domain': domain,

    };
  }
}