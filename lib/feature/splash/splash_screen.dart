import 'package:doktor_randevu/core/constant/assets.dart';
import 'package:doktor_randevu/core/util/local_storage.dart';
import 'package:doktor_randevu/feature/login/presentation/pages/login_screen.dart';
import 'package:doktor_randevu/index_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashState();
}

class _SplashState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }
  Future<void> _checkLoginStatus() async {
    // Simulate some loading delay (optional)
    await Future.delayed(const Duration(seconds: 1));

    // Retrieve the token from SharedPreferences
    final token = await LocalStorage.getToken();

    // Navigate based on whether the token exists or not
    if (token != null && token.isNotEmpty) {
      // If token exists, navigate to the Index screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => IndexScreen()), // Replace with your actual Index screen
      );
    } else {
      // If no token, navigate to the Login screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()), // Replace with your actual Login screen
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: appBody(context),
    );
  }

  Widget appBody(BuildContext context, {Map<String, dynamic>? params}) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Image.asset(Assets.splash, fit: BoxFit.scaleDown),
      ),
    );
  }
}
