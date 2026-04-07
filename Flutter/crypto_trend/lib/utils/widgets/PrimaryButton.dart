import 'package:flutter/material.dart';

import '../AppColors.dart';

class PrimaryButton extends StatelessWidget {
  VoidCallback onPressed;
  Color backgroundColor;
  Color textColor;
  String text;
  String? icon;
  PrimaryButton({super.key, required this.onPressed, required this.text, this.backgroundColor = AppColors.secondary, this.textColor = AppColors.darkBackground, this.icon});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(16),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon != null ? Image.asset(icon!) : SizedBox.shrink(),
          Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: textColor,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
