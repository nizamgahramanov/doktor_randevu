import 'package:doktor_randevu/core/util/main_style.dart';
import 'package:flutter/material.dart';

class Style implements MainStyle {

  @override
  Color color( {String? color }) {
    switch(color) {
      case "main_color":
        return const Color(0XFF3BCF74);
      case "main_grey_color":
        return const Color(0XFFF5F5FA);
      case "secondary_grey_color":
        return const Color(0XFF384357);
      case "main_text_color":
        return const Color(0XFF101825);
      case "secondary_text_color":
        return const Color(0XFF878D98);
      case "deActive_indicator":
        return const Color.fromRGBO(182,182,182, 1);
      case "white":
        return const Color(0XFFFFFFFF);
      case "circle_avatar_color":
        return const Color(0XFFD1D1D6);
      case "grey_text_color":
        return const Color(0XFFAAB0BA);
      case "list_tile_stroke":
        return const Color(0XFFE5E5EA);
      case "list_tile_bg":
        return const Color(0XFFFAFAFA);
      case "error":
        return const Color(0XFFFF3B30);
      case 'black':
        return Colors.black;
      case 'light_grey':
        return const Color(0XFFF9F9F9);
      case "carousel_active_indicator":
        return const Color.fromRGBO(51,51,51 ,1);
        //f9f9f9
      case 'white':
        return Colors.white;
      case 'transparent':
        return Colors.transparent;
      case "active_menu":
        return const Color.fromRGBO(147,147,147, 1);
      case "divider":
        return const Color.fromRGBO(181,181,181, 1);
      case "red":
        return const Color(0XFFFF3B30);
      case "product_bg":
        return const Color.fromRGBO(245,245,245, 1);
      case "tile_line":
        return const Color.fromRGBO(249,249,249, 1);
      case "active_indicator":
        return const Color.fromRGBO(65,58,58, 1);
      case "product_img_border":
        return const Color.fromRGBO(239,239,239, 1);
      case "order_bottom_border":
        return const Color.fromRGBO(238,241,236, 1);
      case "dark_grey":
        return const Color.fromRGBO(100,100,100, 1);
      case "greyText":
        return const Color.fromRGBO(122,122,122, 1);
      case "gray":
        return const Color.fromRGBO(77,77,77, 1);
      case "border_color":
        return const Color.fromRGBO(231,231,231, 1);
      default:
        return Colors.white;
    }
  }

  @override
  TextStyle textStyle({String? textStyle, Map<String, dynamic>? data }) {
    switch(textStyle) {
      case "intro_desc":
        return const TextStyle(
            color: Color.fromRGBO(64, 57, 57, 1),
            fontFamily: 'Poppins',
            fontSize: 16,
            letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
            fontWeight: FontWeight.w400,
            height: 1
        );
      case "intro_title":
        return const TextStyle(
            color: Color.fromRGBO(0, 0, 0, 1),
            fontFamily: 'Poppins',
            fontSize: 24,
            letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
            fontWeight: FontWeight.w600,
            height: 1
        );
      default:
        return const TextStyle(fontWeight: FontWeight.w300, color: Colors.black);
    }
  }

}