import 'package:crypto_trend/core/di/setupLocator.dart';
import 'package:crypto_trend/feature/home/presentation/widgets/CustomTile.dart';
import 'package:crypto_trend/feature/home/presentation/widgets/CustomTitledTile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/AppAssets.dart';
import '../../../utils/AppColors.dart';
import '../../../utils/widgets/CustomAppbar.dart';
import 'cubit/home_cubit.dart';
import 'cubit/home_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(repository: appRepository)..fetchHomeData(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> gridItems = [
      {'title': 'Deposit', 'icon': AppAssets.deposite},
      {'title': 'Referral', 'icon': AppAssets.referal},
      {'title': 'Grid Trading', 'icon': AppAssets.gridTrading},
      {'title': 'Margin', 'icon': AppAssets.margin},
      {'title': 'Launchpad', 'icon': AppAssets.launchPad},
      {'title': 'Savings', 'icon': AppAssets.savings},
      {'title': 'Liquid Swap', 'icon': AppAssets.liquidSwap},
      {'title': 'More', 'icon': AppAssets.more},
    ];
    final List<Map<String, dynamic>> list = [
      {'title': 'P2P Trading', 'icon': AppAssets.rocket, 'desc': 'Bank Transfer, Paypal Revolut...'},
      {'title': 'Credit/Debit Card', 'icon': AppAssets.credit, 'desc': 'Visa, Mastercard'},
    ];

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: const CustomAppbar(),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
            sliver: SliverGrid.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 0.85,
              ),
              itemCount: gridItems.length,
              itemBuilder: (context, index) {
                final item = gridItems[index];
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(item['icon']),
                    const SizedBox(height: 8),
                    Text(item['title'], style: const TextStyle(color: AppColors.lightGrey, fontSize: 12)),
                  ],
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: AppColors.white,
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: list.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      return CustomTile(
                        title: list[index]['title'],
                        desc: list[index]['desc'],
                        image: list[index]['icon'],
                      );
                    },
                  ),
                  const SizedBox(height: 16),

                  BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      if (state is HomeLoading) {
                        return const Center(child: CircularProgressIndicator(color: AppColors.primary));
                      } else if (state is HomeError) {
                        return Center(child: Text("Error: ${state.message}", style: const TextStyle(color: Colors.red)));
                      } else if (state is HomeLoaded) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 75.0),
                          child: Column(
                            children: [
                              CustomTitledTile(title: 'Recent Coins', coinsInfo: state.recentCoins),
                              const SizedBox(height: 24),
                              CustomTitledTile(title: 'Trending Coins', coinsInfo: state.trendingCoins),
                            ],
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}