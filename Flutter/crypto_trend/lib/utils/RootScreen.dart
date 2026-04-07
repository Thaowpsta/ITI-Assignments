import 'package:crypto_trend/utils/AppAssets.dart';
import 'package:crypto_trend/utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/di/setupLocator.dart';
import '../feature/activity/presentation/ActivityScreen.dart';
import '../feature/home/presentation/HomeScreen.dart';
import '../feature/market/presentation/MarketsScreen.dart';
import '../feature/settings/SettingsScreen.dart';
import '../feature/wallet/presentation/WalletScreen.dart';
import '../feature/wallet/presentation/cubit/wallet_cubit.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WalletCubit(repository: appRepository)..loadWallet(),
      child: const RootScreenView(),
    );
  }
}

class RootScreenView extends StatefulWidget {
  const RootScreenView({super.key});

  @override
  State<RootScreenView> createState() => _RootScreenViewState();
}

class _RootScreenViewState extends State<RootScreenView> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    MarketsScreen(),
    ActivityScreen(),
    WalletScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      extendBody: true,

      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 24.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: SizedBox(
            height: 70,
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: AppColors.darkGrey,
              selectedItemColor: AppColors.primary,
              unselectedItemColor: AppColors.grey,
              selectedFontSize: 12,
              unselectedFontSize: 12,
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                  icon: Image.asset(AppAssets.home, width: 32, height: 32, color: AppColors.grey),
                  activeIcon: Image.asset(AppAssets.home, width: 32, height: 32, color: AppColors.primary),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(AppAssets.market, width: 32, height: 32, color: AppColors.grey),
                  activeIcon: Image.asset(AppAssets.market, width: 32, height: 32, color: AppColors.primary),
                  label: 'Markets',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(AppAssets.activity, width: 32, height: 32, color: AppColors.grey),
                  activeIcon: Image.asset(AppAssets.activity, width: 32, height: 32, color: AppColors.primary),
                  label: 'Activity',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(AppAssets.wallet, width: 32, height: 32, color: AppColors.grey),
                  activeIcon: Image.asset(AppAssets.wallet, width: 32, height: 32, color: AppColors.primary),
                  label: 'Wallets',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(AppAssets.gear, width: 32, height: 32, color: AppColors.grey),
                  activeIcon: Image.asset(AppAssets.gear, width: 32, height: 32, color: AppColors.primary),
                  label: 'Settings',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}