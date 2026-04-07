import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../../../utils/AppColors.dart';

Widget buildAddFavoriteButton() {
  return Padding(
    padding: const EdgeInsets.only(top: 8.0, bottom: 100.0),
    child: InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(12),
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          color: AppColors.grey,
          strokeWidth: 2,
          dashPattern: const [8, 4],
          radius: const Radius.circular(12),
        ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.lightBackground,
                ),
                child: const Icon(
                  Icons.add,
                  color: AppColors.grey,
                  size: 16,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'Add Favorite',
                style: TextStyle(
                  color: AppColors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}