import 'package:flutter/material.dart';

import '../../../utils/AppColors.dart' show AppColors;

class CustomBody extends StatelessWidget {
  const CustomBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore.",
      style: TextStyle(
        fontWeight: FontWeight.w400,
        color: AppColors.grey,
        fontSize: 18,
      ),
      textAlign: TextAlign.center,
    );
  }
}
