import 'package:doktor_randevu/core/util/screens.dart';
import 'package:doktor_randevu/feature/booking/data/models/conclusion.dart';
import 'package:doktor_randevu/feature/booking/presentation/pages/booking_screen.dart';
import 'package:doktor_randevu/feature/booking/presentation/pages/conclusion_screen.dart';
import 'package:doktor_randevu/feature/client/presentation/pages/client_screen.dart';
import 'package:doktor_randevu/feature/login/presentation/pages/login_screen.dart';
import 'package:doktor_randevu/feature/service/presentation/pages/service_screen.dart';
import 'package:doktor_randevu/feature/slot/presentation/pages/slot_screen.dart';
import 'package:doktor_randevu/feature/splash/splash_screen.dart';
import 'package:doktor_randevu/index_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Screens.booking:
        return MaterialPageRoute(settings: settings, builder: (_) => BookingScreen());
      case Screens.service:
        return MaterialPageRoute(settings: settings, builder: (_) => ServiceScreen(conclusion: settings.arguments! as Conclusion));
      case Screens.slot:
        return MaterialPageRoute(settings: settings, builder: (_) => SlotScreen(conclusion: settings.arguments! as Conclusion));
      case Screens.client:
        return MaterialPageRoute(settings: settings, builder: (_) => ClientScreen(conclusion: settings.arguments! as Conclusion));
      case Screens.conclusion:
        return MaterialPageRoute(settings: settings, builder: (_) => ConclusionScreen(conclusion: settings.arguments! as Conclusion));
      case Screens.index:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => IndexScreen(),
        );
      case Screens.splash:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => SplashScreen(),
        );
      case Screens.login:
        return MaterialPageRoute(settings: settings, builder: (_) => LoginScreen());
      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const Center(
            child: Text('undefined route'),
          ),
        );
    }
  }
}
