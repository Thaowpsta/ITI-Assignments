import 'package:flutter/material.dart';

import 'CoinCard.dart';

class CustomTitledTile extends StatelessWidget {

  List<Map<String, dynamic>> coinsInfo;
  String title;

  CustomTitledTile({super.key, required this.title, required this.coinsInfo});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        SizedBox(
          height: 175,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: coinsInfo.length,
            itemBuilder: (context, index) {
              final coin = coinsInfo[index];
              return CoinCard(
                price: coin['price'],
                pair: coin['pair'],
                percentage: coin['percentage'],
                coinIcon: coin['coinIcon'],
                chartImage: coin['chartImage'],
                isPositive: coin['isPositive'],
              );
            },
          ),
        ),
      ],
    );
  }
}