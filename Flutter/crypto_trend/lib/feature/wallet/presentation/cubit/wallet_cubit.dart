import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/repository/AppRepository.dart';
import 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  final AppRepository repository;

  WalletCubit({required this.repository}) : super(WalletInitial());

  Future<void> loadWallet() async {
    emit(WalletLoading());
    try {
      final data = await repository.getWalletCoins();
      double tempBalance = 0.0;

      for (var coin in data) {
        tempBalance += (coin['price'] * coin['amount']);
      }

      emit(WalletLoaded(data, tempBalance));
    } catch (e) {
      emit(WalletError(e.toString()));
    }
  }

  Future<void> deleteCoin(int id) async {
    try {
      await repository.removeCoinFromWallet(id);
      await loadWallet();
    } catch (e) {
      emit(WalletError(e.toString()));
    }
  }
}