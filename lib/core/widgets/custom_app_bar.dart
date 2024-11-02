
import 'package:doktor_randevu/core/di/injection.dart';
import 'package:doktor_randevu/core/util/style.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final List<Widget>? actionButton;
  final bool showBackButton;

  CustomAppBar({required this.title, this.showBackButton = false, this.actionButton});

  @override
  Widget build(BuildContext context) {
    final Style _style = sl<Style>();
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      leading: showBackButton
          ? InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 4, right: 4, bottom: 4),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _style.color(color: 'main_grey_color'),
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 18,
                    color: _style.color(color: 'secondary_grey_color'),
                  ),
                ),
              ),
            )
          : null,
      title: title,
/*      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontFamily: 'PublicSans',
          fontWeight: FontWeight.bold,
          color: _style.color(
            color: 'secondary_grey_color',
          ),
        ),
      ),*/
      centerTitle: true,
      actions: actionButton,
      elevation: 2.0,
      shadowColor: Colors.grey.withOpacity(0.5),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
