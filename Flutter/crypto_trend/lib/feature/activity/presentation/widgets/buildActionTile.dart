import 'package:flutter/material.dart';

import '../../../../utils/AppColors.dart';


Widget buildActionTile(IconData icon, String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
    child: Row(
      children: [
        Icon(icon, color: AppColors.lightGrey, size: 22),
        const SizedBox(width: 16),
        Text(
          title,
          style: const TextStyle(color: AppColors.white, fontSize: 16),
        ),
        const Spacer(),
        Icon(Icons.arrow_forward_rounded, color: AppColors.grey, size: 20),
      ],
    ),
  );
}