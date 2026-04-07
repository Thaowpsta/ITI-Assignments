import 'package:crypto_trend/utils/AppColors.dart';
import 'package:flutter/material.dart';

class ActivityItemTile extends StatelessWidget {
  final String type;
  final bool isBuy;
  final String symbol;
  final String date;
  final String amount;
  final String price;
  final String status;

  const ActivityItemTile({
    super.key,
    required this.type,
    required this.isBuy,
    required this.symbol,
    required this.date,
    required this.amount,
    required this.price,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final Color highlightColor = isBuy ? AppColors.primary : AppColors.error;
    final Color avatarBgColor = AppColors.darkBackground;
    final TextStyle greyLabelStyle = TextStyle(color: AppColors.grey, fontSize: 14);

    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: avatarBgColor,
            child: Text(
              type,
              style: TextStyle(
                color: highlightColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      symbol,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Text(date, style: TextStyle(color: AppColors.grey, fontSize: 12)),
                        const SizedBox(width: 4),
                        Icon(Icons.chevron_right, color: AppColors.grey, size: 16),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Amount", style: greyLabelStyle),
                    Text(amount, style: TextStyle(color: AppColors.success, fontSize: 14)),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Price", style: greyLabelStyle),
                    Text(price, style: greyLabelStyle),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Status", style: greyLabelStyle),
                    Text(
                      status,
                      style: TextStyle(
                        color: highlightColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}