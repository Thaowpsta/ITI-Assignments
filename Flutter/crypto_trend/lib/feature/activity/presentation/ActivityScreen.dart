import 'package:crypto_trend/core/di/setupLocator.dart';
import 'package:crypto_trend/feature/activity/presentation/widgets/ActivityItemTile.dart';
import 'package:crypto_trend/feature/activity/presentation/widgets/buildActionTile.dart';
import 'package:crypto_trend/utils/AppColors.dart';
import 'package:crypto_trend/utils/widgets/CustomAppbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  bool isLoading = true;
  List<Map<String, dynamic>> activities = [];

  @override
  void initState() {
    super.initState();
    fetchActivityData();
  }

  void fetchActivityData() async {
    try {
      final data = await appRepository.getUserActivity();

      List<Map<String, dynamic>> mappedActivities = data.map((order) {

        DateTime date = DateTime.fromMillisecondsSinceEpoch(order['time']);
        String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(date);

        bool isBuy = order['side'] == 'BUY';
        String typeLabel = order['type'] == 'LIMIT' ? 'L' : 'M';
        String sideLabel = isBuy ? 'B' : 'S';

        return {
          'type': '$typeLabel/$sideLabel',
          'isBuy': isBuy,
          'symbol': order['symbol'].toString().replaceFirst(RegExp(r'(BUSD|USDT)$'), r'/$1'),
          'date': formattedDate,
          'amount': '${order['executedQty']}/${order['origQty']}',
          'price': order['price'],
          'status': order['status'].toString().substring(0, 1).toUpperCase() + order['status'].toString().substring(1).toLowerCase(),
        };
      }).toList();

      setState(() {
        activities = mappedActivities;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: const CustomAppbar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.darkSurface,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    buildActionTile(Icons.payments_outlined, "Deposit"),
                    buildActionTile(Icons.outbox_rounded, "Withdrawals"),
                    buildActionTile(Icons.shopping_cart_outlined, "Buy Order"),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              const Text(
                "Recent Activity",
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              isLoading
                  ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
                  : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: activities.length,
                itemBuilder: (context, index) {
                  final activity = activities[index];
                  return ActivityItemTile(
                    type: activity['type'],
                    isBuy: activity['isBuy'],
                    symbol: activity['symbol'],
                    date: activity['date'],
                    amount: activity['amount'],
                    price: activity['price'],
                    status: activity['status'],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}