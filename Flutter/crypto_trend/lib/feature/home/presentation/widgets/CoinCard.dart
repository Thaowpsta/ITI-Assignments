import 'package:crypto_trend/utils/AppColors.dart';
import 'package:flutter/material.dart';

import 'MiniChartWidget.dart';

class CoinCard extends StatelessWidget {
  final String price;
  final String pair;
  final String percentage;
  final String coinIcon;
  final List<double> chartImage;
  final bool isPositive;

  const CoinCard({
    super.key,
    required this.price,
    required this.pair,
    required this.percentage,
    required this.coinIcon,
    required this.chartImage,
    this.isPositive = true,
  });

  @override
  Widget build(BuildContext context) {
    final Color trendColor = isPositive ? AppColors.secondary : AppColors.error;

    return Card(
      color: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        width: 170,
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  price,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: trendColor,
                  ),
                ),
                coinIcon.startsWith('http')
                    ? Image.network(coinIcon, width: 24, height: 24, errorBuilder: (context, error, stackTrace) => Icon(Icons.money))
                    : Image.asset(coinIcon, width: 24, height: 24),
              ],
            ),
            const SizedBox(height: 8),

            Row(
              children: [
                Expanded(
                  child: Text(
                    pair,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  percentage,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: trendColor,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            SizedBox(
              height: 60,
              width: double.infinity,
              child: MiniChartWidget(
                data: chartImage,
                color: trendColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}