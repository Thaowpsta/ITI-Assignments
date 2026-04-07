import 'package:crypto_trend/utils/AppColors.dart';
import 'package:crypto_trend/utils/AppAssets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/wallet_cubit.dart';
import 'cubit/wallet_state.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: BlocBuilder<WalletCubit, WalletState>(
        builder: (context, state) {
          if (state is WalletLoading || state is WalletInitial) {
            return const Center(child: CircularProgressIndicator(color: AppColors.primary));
          } else if (state is WalletError) {
            return Center(child: Text(state.message, style: const TextStyle(color: AppColors.error)));
          } else if (state is WalletLoaded) {
            return Column(
              children: [
                const SizedBox(height: 24),
                const Text('Total Balance', style: TextStyle(color: AppColors.grey)),
                Text(
                    '\$${state.totalBalance.toStringAsFixed(2)}',
                    style: const TextStyle(color: AppColors.white, fontSize: 32)
                ),
                const SizedBox(height: 16),

                Expanded(
                  child: state.walletCoins.isEmpty
                      ? const Center(
                    child: Text("Your wallet is empty.", style: TextStyle(color: AppColors.grey)),
                  )
                      : ListView.builder(
                    itemCount: state.walletCoins.length,
                    itemBuilder: (context, index) {
                      final coin = state.walletCoins[index];

                      return Dismissible(
                        key: Key(coin['id'].toString()),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: AppColors.error,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          child: const Icon(Icons.delete, color: AppColors.white),
                        ),
                        confirmDismiss: (direction) async {
                          return await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Confirm"),
                                content: const Text("Are you sure you want to delete this coin from your wallet?"),
                                actions: [
                                  TextButton(
                                      onPressed: () => Navigator.of(context).pop(false),
                                      child: const Text("CANCEL")
                                  ),
                                  TextButton(
                                      onPressed: () => Navigator.of(context).pop(true),
                                      child: const Text("DELETE", style: TextStyle(color: AppColors.error))
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        onDismissed: (direction) {
                          context.read<WalletCubit>().deleteCoin(coin['id']);
                        },
                        child: ListTile(
                          leading: Image.asset(coin['icon'] ?? AppAssets.bitCoin),
                          title: Text(coin['symbol'], style: const TextStyle(color: AppColors.white)),
                          subtitle: Text('Amount: ${coin['amount']}', style: const TextStyle(color: AppColors.grey)),
                          trailing: Text(
                              '\$${(coin['price'] * coin['amount']).toStringAsFixed(2)}',
                              style: const TextStyle(color: Colors.white)
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}