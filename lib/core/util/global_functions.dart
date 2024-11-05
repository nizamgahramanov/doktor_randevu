
import 'package:doktor_randevu/core/di/injection.dart';
import 'package:doktor_randevu/core/util/style.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GlobalFunctions {
  static final GlobalFunctions _instance = GlobalFunctions._internal();

  GlobalFunctions._internal();

  static GlobalFunctions get instance => _instance;

  Future<void> showCloseDialog(
      {required String title,
      String? description,
        String? svgPath,
      required Color buttonBackground,
      VoidCallback? onButtonPressed, required BuildContext context}) async {
    final Style _style = sl<Style>();
    return await showDialog(
      context: context,
      builder: (_) => SimpleDialog(
        backgroundColor:_style.color(color: 'main_grey_color'),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
        title: Column(
          children: [
            if(svgPath!=null)
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _style.color(color: 'white'),
                  ),
                  child: SvgPicture.asset(
                    svgPath,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w400,
                fontFamily: 'PublicSans',
                color: _style.color(
                  color: 'main_text_color',
                ),
              ),
            ),
            if (description != null)
              Column(
                children: [
                  const SizedBox(height: 10),
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'PublicSans',
                      color: _style.color(
                        color: 'secondary_grey_color',
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
          ],
        ),
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: ElevatedButton(
              onPressed: onButtonPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonBackground,
              ),
              child: Text(
                AppLocalizations.of(context)!.close,
                style:TextStyle(
                  fontSize: 14,
                  fontFamily: 'PublicSans',
                  fontWeight: FontWeight.bold,
                  color: _style.color(
                    color: 'white',
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> showAlertDialog(
      {required String title,
        String? description,
        String? svgPath,
        required Color buttonBackground,
        VoidCallback? onFirstButtonPressed,VoidCallback? onSecondButtonPressed, required BuildContext context}) async {
    final Style _style = sl<Style>();
    return await showDialog(
      context: context,
      builder: (_) => SimpleDialog(
        backgroundColor:_style.color(color: 'main_grey_color'),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
        title: Column(
          children: [
            if(svgPath!=null)
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _style.color(color: 'white'),
                    ),
                    child: SvgPicture.asset(
                      svgPath,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            Text(
              title,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w400,
                fontFamily: 'PublicSans',
                color: _style.color(
                  color: 'main_text_color',
                ),
              ),
            ),
            if (description != null)
              Column(
                children: [
                  const SizedBox(height: 10),
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'PublicSans',
                      color: _style.color(
                        color: 'secondary_grey_color',
                      ),
                    ),
                  ),
                  // const SizedBox(height: 10),
                ],
              ),
          ],
        ),
        children: [
          Column(children: [
            const Divider(height: 1,thickness: 1,),
            InkWell(
              onTap: onFirstButtonPressed,
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      AppLocalizations.of(context)!.logout,
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'PublicSans',
                        color: _style.color(color: 'red'),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Divider(height: 1,thickness: 1),
            InkWell(
              onTap: onSecondButtonPressed,
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      AppLocalizations.of(context)!.reject,
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'PublicSans',
                        color: _style.color(color: 'main_text_color'),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],)
        ],
      ),
    );
  }
  void showSnackBar({
    required BuildContext context,
    required String message,
    Color backgroundColor = Colors.black,
    int durationSeconds = 3,
    SnackBarAction? action,
  }) {
    final Style _style = sl<Style>();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            fontSize: 14,
            fontFamily: 'PublicSans',
            color: _style.color(color: 'white'),
          ),
        ),
        backgroundColor: backgroundColor,
        duration: Duration(seconds: durationSeconds),
        action: action,
      ),
    );
  }
  static void setStatusBarColor(Color color) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: color),
    );
  }
  static void showSnackBar2({
    required String message,
    required bool positive,
  }) async {
    final statusBarHeight = MediaQuery.of(ctx!).padding.top;

    showFlash(
      context: ctx!,
      duration: const Duration(seconds: 3),
      builder: (context, controller) {
        return FlashBar(
          controller: controller,
          backgroundColor: !positive ? Colors.redAccent : Colors.lightGreen,
          position: FlashPosition.top,
          useSafeArea: false,
          behavior: FlashBehavior.floating,
          content: Container(
            padding: const EdgeInsets.all(16.0).copyWith(top: statusBarHeight + 16.0),
            child: Text(
              '$message',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}
