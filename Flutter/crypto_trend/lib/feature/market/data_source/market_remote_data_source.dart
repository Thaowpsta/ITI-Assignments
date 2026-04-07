import 'package:crypto_trend/core/network/DioHelper.dart';

class MarketRemoteDataSource {
  final String _binanceUrl = 'https://api.binance.com';
  final String _coinGeckoUrl = 'https://api.coingecko.com/api/v3';

  Future<List<dynamic>> fetchTickers() async {
    final response = await DioHelper.getData(
      url: "$_binanceUrl/api/v3/ticker/24hr",
    );
    return response.data;
  }

  Future<List<dynamic>> fetchMarkets() async {
    final response = await DioHelper.getData(
        url: "$_coinGeckoUrl/coins/markets",
        query: {
          "vs_currency": "usd",
          "per_page": 100,
          "page": 1,
          "sparkline": true,
        }
    );
    return response.data;
  }
}