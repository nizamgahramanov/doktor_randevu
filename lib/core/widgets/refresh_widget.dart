
import 'package:doktor_randevu/core/di/injection.dart';
import 'package:doktor_randevu/core/util/screens.dart';
import 'package:doktor_randevu/core/util/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RefreshWidget extends StatelessWidget {
  const RefreshWidget({Key? key, required this.onPressed}) : super(key: key);
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    final Style _style = sl<Style>();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              AppLocalizations.of(context)!.refresh,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'PublicSans',
                color: _style.color(
                  color: 'main_text_color',
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 32,),
            padding: const EdgeInsets.all(8),
            child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: (){
                Navigator.pushNamed(context, Screens.login,);
              },
              child: Text(
                AppLocalizations.of(context)!.backToLogin,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  fontFamily: 'PublicSans',
                  color: _style.color(
                    color: 'main_text_color',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
