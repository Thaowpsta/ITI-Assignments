import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/repository/AppRepository.dart';
import '../../../../utils/AppAssets.dart';
import 'market_state.dart';

class MarketCubit extends Cubit<MarketState> {
  final AppRepository repository;

  MarketCubit({required this.repository}) : super(MarketInitial());

  Future<void> fetchMarketData() async {
    emit(MarketLoading());
    try {
      final results = await Future.wait([
        repository.getBinanceTickers(),
        repository.getMarkets(),
      ]);

      final List<dynamic> binanceData = results[0];
      final List<dynamic> geckoData = results[1];

      final usdtPairs = binanceData.where((item) => item['symbol'].toString().endsWith('USDT')).take(20).toList();

      List<Map<String, dynamic>> mappedCoins = usdtPairs.map((binanceCoin) {
        String symbol = binanceCoin['symbol'].toString().replaceAll('USDT', '').toLowerCase();

        final geckoMatch = geckoData.firstWhere(
              (g) => g['symbol'].toString().toLowerCase() == symbol,
          orElse: () => null,
        );

        double priceChange = double.tryParse(binanceCoin['priceChangePercent'] ?? '0') ?? 0;
        double lastPrice = double.tryParse(binanceCoin['lastPrice'] ?? '0') ?? 0;
        bool isPositive = priceChange >= 0;

        List<double> realChart = [];
        if (geckoMatch != null && geckoMatch['sparkline_in_7d'] != null) {
          realChart = (geckoMatch['sparkline_in_7d']['price'] as List)
              .map((p) => (p as num).toDouble())
              .toList();
        } else {
          realChart = isPositive ? [1.0, 2.0, 3.0, 4.0] : [4.0, 3.0, 2.0, 1.0];
        }

        return {
          'title': symbol.toUpperCase(),
          'desc': binanceCoin['symbol'],
          'price': '\$${lastPrice.toStringAsFixed(2)}',
          'percentage': '${isPositive ? '+' : ''}${priceChange.toStringAsFixed(2)}%',
          'icon': geckoMatch != null ? geckoMatch['image'] : AppAssets.bitCoin,
          'isPositive': isPositive,
          'chartData': realChart,
        };
      }).toList();

      emit(MarketLoaded(spotCoins: mappedCoins));
    } catch (e) {
      emit(MarketError(e.toString()));
    }
  }

  Future<bool> addToWallet(String title, double rawPrice, double amount, String icon) async {
    try {
      await repository.addCoinToWallet(title, rawPrice, amount, icon);
      return true;
    } catch (e) {
      return false;
    }
  }
}