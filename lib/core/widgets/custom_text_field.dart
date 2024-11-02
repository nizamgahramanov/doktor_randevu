
import 'package:doktor_randevu/core/di/injection.dart';
import 'package:doktor_randevu/core/util/style.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {Key? key,
      this.controller,
      required this.keyboardType,
      this.onChanged,
      required this.onFieldSubmitted,
      this.onSaved,
      required this.textInputAction,
      this.focusNode,
      this.hintText,
      this.obscureText = false,
      this.validator,
      this.suffixIcon,
      this.maxLines = 1})
      : super(key: key);
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String> onFieldSubmitted;
  final ValueChanged? onSaved;
  final TextInputAction textInputAction;
  final FocusNode? focusNode;
  final bool obscureText;
  final String? hintText;
  final String? Function(String?)? validator;
  final int maxLines;
  final Widget? suffixIcon;
  @override
  Widget build(BuildContext context) {
    final Style _style = sl<Style>();
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      onChanged: onChanged,
      maxLines: maxLines,
      focusNode: focusNode,
      validator: validator,
      onFieldSubmitted: onFieldSubmitted,
      obscuringCharacter: "*",
      style: TextStyle(
        fontSize: 15.0,
        color: _style.color(color: 'main_text_color'),
        fontFamily: 'PublicSans',
      ),

      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
        filled: true,
        hintText: hintText,
        suffixIcon: suffixIcon,
        // suffixIconConstraints: const BoxConstraints(
        //   minWidth: 38,
        //   minHeight: 38,
        //   maxWidth: 38,
        //   maxHeight: 38,
        // ),
        hintStyle: TextStyle(
          fontSize: 15.0,
          color: _style.color(color: 'grey_text_color'),
          fontFamily: 'PublicSans',
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
          // borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: _style.color(color: 'main_color'),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: _style.color(color: 'error'),
          ),
        ),
      ),
      onSaved: onSaved,
    );
  }
}
