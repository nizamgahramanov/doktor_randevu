import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const String _localeKey = 'locale_key';
const String _themeKey = 'theme_key';
const String _refreshTokenKey = 'refresh_token_key';
const String _tokenKey = 'token';
const String _companyKey = 'company';
const String _passwordKey = 'password';
const String _emailKey = 'email';
const String _providerIdKey = 'providerId';

class LocalStorage {
  static const _storage = FlutterSecureStorage();

  static Future<void> setLocale(String languageCode) async {
    await _storage.write(key: _localeKey, value: languageCode);
  }

  static Future<Locale> getLocale() async {
    final value = await _storage.read(key: _localeKey);

    if (value == null) {
      return const Locale('az', 'AZ');
    }

    final locale = Locale(value, value.toUpperCase());
    return locale;
  }

  static Future<void> setThemeMode(ThemeMode mode) async {
    await _storage.write(key: _themeKey, value: mode.name);
  }

  static Future<ThemeMode> getThemeMode() async {
    final value = await _storage.read(key: _themeKey);

    if (value == null) {
      return ThemeMode.light;
    }

    if (value == ThemeMode.light.name) {
      return ThemeMode.light;
    }

    if (value == ThemeMode.dark.name) {
      return ThemeMode.dark;
    }

    return ThemeMode.light;
  }

  static Future<void> setRefreshToken(String? refreshToken) async {
    await _storage.write(key: _refreshTokenKey, value: refreshToken);
  }

  static Future<void> removeRefreshToken() async {
    await _storage.delete(key: _refreshTokenKey);
  }

  static Future<String?> getRefreshToken() async {
    final value = await _storage.read(key: _refreshTokenKey);
    return value;
  }

  static Future<void> setToken(String? token) async {
    await _storage.write(key: _tokenKey, value: token);
  }
  static Future<void> setPassword(String password) async {
    await _storage.write(key: _passwordKey, value: password);
  }

  static Future<void> removeToken() async {
    await _storage.delete(key: _tokenKey);
  }

  static Future<String?> getToken() async {
    final value = await _storage.read(key: _tokenKey);
    return value;
  }
  static Future<String?> getCompany() async {
    final value = await _storage.read(key: _companyKey);
    return value;
  }
  static Future<String?> getPassword() async {
    final value = await _storage.read(key: _passwordKey);
    return value;
  }

  static Future<void> setProviderId(int id) async {
    await _storage.write(key: _providerIdKey, value: id.toString());
  }

  static Future<String?> getProviderId() async {
    final value = await _storage.read(key: _providerIdKey);
    return value;
  }

  static Future<void> setProviderEmail(String email) async {
    await _storage.write(key: _emailKey, value: email);
  }
  static Future<String?> getProviderEmail() async {
    final value = await _storage.read(key: _emailKey);
    return value;
  }
}
