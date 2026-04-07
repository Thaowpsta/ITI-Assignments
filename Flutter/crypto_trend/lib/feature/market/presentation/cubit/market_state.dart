import 'package:equatable/equatable.dart';

abstract class MarketState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MarketInitial extends MarketState {}

class MarketLoading extends MarketState {}

class MarketLoaded extends MarketState {
  final List<Map<String, dynamic>> spotCoins;

  MarketLoaded({required this.spotCoins});

  @override
  List<Object?> get props => [spotCoins];
}

class MarketError extends MarketState {
  final String message;

  MarketError(this.message);

  @override
  List<Object?> get props => [message];
}