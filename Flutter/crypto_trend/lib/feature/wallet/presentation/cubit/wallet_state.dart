import 'package:equatable/equatable.dart';

abstract class WalletState extends Equatable {
  @override
  List<Object?> get props => [];
}

class WalletInitial extends WalletState {}

class WalletLoading extends WalletState {}

class WalletLoaded extends WalletState {
  final List<Map<String, dynamic>> walletCoins;
  final double totalBalance;

  WalletLoaded(this.walletCoins, this.totalBalance);

  @override
  List<Object?> get props => [walletCoins, totalBalance];
}

class WalletError extends WalletState {
  final String message;

  WalletError(this.message);

  @override
  List<Object?> get props => [message];
}