import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry margin;
  final Color backgroundColor;
  final double borderRadius;
  final TextStyle? buttonTextStyle;
  final Widget? loadingIcon;
  final bool showDivider;

  const CustomElevatedButton({
    Key? key,
    required this.buttonText,
    required this.onPressed,
    this.margin = EdgeInsets.zero,
    required this.backgroundColor,
    this.borderRadius = 6,
    this.buttonTextStyle,
    this.loadingIcon,
    this.showDivider = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (showDivider)
          const Divider(
            height: 1,
          ),
        Container(
          margin: margin,
          child: ElevatedButton(
            onPressed: loadingIcon != null ? () {} : onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: backgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(buttonText, style: buttonTextStyle),
                const SizedBox(width: 8), // Space between text and icon
                // Add a SizedBox to ensure the width remains constant
                SizedBox(
                  width: loadingIcon != null ? 20 : 0, // Adjust width as needed
                  child: loadingIcon,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
