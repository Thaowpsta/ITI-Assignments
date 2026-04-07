import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/repository/AppRepository.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final AppRepository repository;

  HomeCubit({required this.repository}) : super(HomeInitial());

  Future<void> fetchHomeData() async {
    emit(HomeLoading());
    try {
      final trendingRaw = await repository.getTrendingCoins();
      List<String> trendingIds = trendingRaw.map((coin) => coin['item']['id'].toString()).toList();

      final responses = await Future.wait([
        repository.getMarketsByIds(trendingIds),
        repository.getMarkets(),
      ]);

      final trendingMarkets = responses[0];
      final marketsData = responses[1];

      List<Map<String, dynamic>> mappedTrending = _mapCoins(trendingMarkets);
      List<Map<String, dynamic>> mappedRecent = _mapCoins(marketsData.take(5).toList());

      emit(HomeLoaded(trendingCoins: mappedTrending, recentCoins: mappedRecent));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  List<Map<String, dynamic>> _mapCoins(List<dynamic> rawList) {
    return rawList.map((coin) {
      double price = (coin['current_price'] as num).toDouble();
      double priceChange = (coin['price_change_percentage_24h'] as num?)?.toDouble() ?? 0.0;
      bool isPositive = priceChange >= 0;

      List<double> sparkline = [];
      if (coin['sparkline_in_7d'] != null && coin['sparkline_in_7d']['price'] != null) {
        sparkline = (coin['sparkline_in_7d']['price'] as List)
            .map((p) => (p as num).toDouble())
            .toList();
      }

      return {
        'price': '\$${price.toStringAsFixed(2)}',
        'pair': coin['symbol'].toString().toUpperCase(),
        'percentage': '${isPositive ? '+' : ''}${priceChange.toStringAsFixed(2)}%',
        'coinIcon': coin['image'],
        'isPositive': isPositive,
        'chartImage': sparkline,
      };
    }).toList();
  }
}