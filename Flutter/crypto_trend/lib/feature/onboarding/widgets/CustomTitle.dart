import 'package:flutter/material.dart';

import '../../../utils/AppColors.dart';

class CustomTitle extends StatelessWidget {
  String title;

  CustomTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.w400,
        color: AppColors.white,
        fontSize: 23,
      ),
    );
  }
}
