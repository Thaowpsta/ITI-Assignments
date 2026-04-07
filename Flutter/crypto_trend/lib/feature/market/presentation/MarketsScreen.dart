import 'package:crypto_trend/feature/market/presentation/widgets/CustomSpotTile.dart';
import 'package:crypto_trend/feature/market/presentation/widgets/buildAddFavoriteButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/setupLocator.dart';
import '../../../utils/AppColors.dart';
import '../../../utils/widgets/CustomAppbar.dart';
import '../../wallet/presentation/cubit/wallet_cubit.dart';
import 'cubit/market_cubit.dart';
import 'cubit/market_state.dart';

class MarketsScreen extends StatelessWidget {
  const MarketsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MarketCubit(repository: appRepository)..fetchMarketData(),
      child: const MarketsView(),
    );
  }
}

class MarketsView extends StatelessWidget {
  const MarketsView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 1, 
      child: Scaffold(
        backgroundColor: AppColors.darkBackground,
        appBar: const CustomAppbar(),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Container(
                height: 48,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.darkSurface,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TabBar(
                  dividerColor: Colors.transparent,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                    color: AppColors.darkGrey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  labelColor: AppColors.white,
                  unselectedLabelColor: AppColors.grey,
                  labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                  splashFactory: NoSplash.splashFactory,
                  overlayColor: const WidgetStatePropertyAll(Colors.transparent),
                  tabs: const [
                    Tab(text: "Convert"),
                    Tab(text: "Spot"),
                    Tab(text: "Margin"),
                    Tab(text: "Fiat"),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  const Center(child: Text('Convert Content', style: TextStyle(color: AppColors.white))),

                  BlocBuilder<MarketCubit, MarketState>(
                    builder: (context, state) {
                      if (state is MarketLoading || state is MarketInitial) {
                        return const Center(child: CircularProgressIndicator(color: AppColors.primary));
                      } else if (state is MarketError) {
                        return Center(child: Text("Error: ${state.message}", style: const TextStyle(color: Colors.red)));
                      } else if (state is MarketLoaded) {
                        final spotCoins = state.spotCoins;

                        return ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                          itemCount: spotCoins.length + 1,
                          separatorBuilder: (context, index) => const SizedBox(height: 32),
                          itemBuilder: (context, index) {
                            if (index == spotCoins.length) {
                              return buildAddFavoriteButton();
                            }
                            final item = spotCoins[index];
                            return InkWell(
                              onLongPress: () async {
                                double rawPrice = double.parse(item['price'].replaceAll('\$', ''));

                                bool success = await context.read<MarketCubit>().addToWallet(
                                    item['title'], rawPrice, 1.0, item['icon']
                                );

                                if (success && context.mounted) {
                                  context.read<WalletCubit>().loadWallet();

                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('${item['title']} added to Wallet'))
                                  );
                                }
                              },
                              child: CustomSpotTile(
                                title: item['title'],
                                desc: item['desc'],
                                icon: item['icon'],
                                percentage: item['percentage'],
                                price: item['price'],
                                chartData: item['chartData'],
                                isPositive: item['isPositive'],
                              ),
                            );
                          },
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),

                  const Center(child: Text('Margin Content', style: TextStyle(color: AppColors.white))),
                  const Center(child: Text('Fiat Content', style: TextStyle(color: AppColors.white))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}