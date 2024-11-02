
import 'package:doktor_randevu/core/di/injection.dart';
import 'package:doktor_randevu/core/util/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class NoConnectivityIndicator extends StatelessWidget {
  final Style _style = sl<Style>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              CupertinoIcons.wifi_exclamationmark,
              size: 50.0,
              color: Colors.redAccent,
            ),
            SizedBox(height: 40.0),
            Text(
              AppLocalizations.of(context)!.noInternetConnection,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'PublicSans',
                color: _style.color(
                  color: 'main_text_color',
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Center(
              child: Text(
                AppLocalizations.of(context)!.noInternetConnectionDetails,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'PublicSans',
                  color: _style.color(
                    color: 'secondary_text_color',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
