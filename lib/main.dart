
import 'dart:io';

import 'package:doktor_randevu/core/util/certificates.dart';
import 'package:doktor_randevu/core/util/screens.dart';
import 'package:doktor_randevu/firebase_options.dart';
import 'package:doktor_randevu/l10n/l10n.dart';
import 'package:doktor_randevu/route_generator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:doktor_randevu/core/di/injection.dart' as di;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'core/util/local_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  HttpOverrides.global = MyHttpOverrides();
  OneSignal.shared.setLogLevel(OSLogLevel.error, OSLogLevel.none);
  OneSignal.shared.setAppId("bfa40d25-2d13-4f6f-b780-67c823604686");
  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    print("Accepted permission: $accepted");
  });
  final token = await LocalStorage.getToken();
  runApp(MyApp(
    token: token,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.token});
  final String? token;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doktor Randevu',
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: const Locale('az'),
      supportedLocales: L10n.all,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: false,
      ),
      initialRoute: token != '' && token != null ? Screens.index : Screens.login,
      // initialRoute: Screens.splash,
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
