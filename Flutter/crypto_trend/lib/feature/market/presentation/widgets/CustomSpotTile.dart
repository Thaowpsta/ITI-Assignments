import 'package:crypto_trend/utils/AppColors.dart';
import 'package:flutter/material.dart';

import '../../../home/presentation/widgets/MiniChartWidget.dart';

class CustomSpotTile extends StatelessWidget {
  final String title;
  final String desc;
  final String icon;
  final String percentage;
  final String price;
  final List<double>? chartData;
  final bool? isPositive;

  const CustomSpotTile({
    super.key,
    required this.title,
    required this.desc,
    required this.icon,
    required this.percentage,
    required this.price,
    this.chartData,
    this.isPositive,
  });

  @override
  Widget build(BuildContext context) {
    final bool status = isPositive ?? true;

    final Color trendColor = status ? AppColors.secondary : AppColors.error;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        icon.startsWith('http')
            ? Image.network(icon, width: 24, height: 24, errorBuilder: (context, error, stackTrace) => Icon(Icons.money))
            : Image.asset(icon, width: 24, height: 24),
        const SizedBox(width: 12),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(color: AppColors.white, fontSize: 16, fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            Text(desc, style: const TextStyle(color: AppColors.grey, fontSize: 14, fontWeight: FontWeight.w400)),
          ],
        ),

        if (chartData != null)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: SizedBox(
                height: 40,
                child: MiniChartWidget(data: chartData!, color: trendColor),
              ),
            ),
          )
        else
          const Spacer(),

        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(price, style: const TextStyle(color: AppColors.white, fontSize: 16, fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            Text(percentage, style: TextStyle(color: trendColor, fontSize: 14, fontWeight: FontWeight.w400)),
          ],
        ),
      ],
    );
  }
}