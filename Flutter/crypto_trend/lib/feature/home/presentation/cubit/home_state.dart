import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Map<String, dynamic>> trendingCoins;
  final List<Map<String, dynamic>> recentCoins;

  HomeLoaded({required this.trendingCoins, required this.recentCoins});

  @override
  List<Object?> get props => [trendingCoins, recentCoins];
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);

  @override
  List<Object?> get props => [message];
}