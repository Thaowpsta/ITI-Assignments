import 'package:crypto_trend/core/network/DioHelper.dart';

class HomeRemoteDataSource {
  final String _baseUrl = 'https://api.coingecko.com/api/v3';

  Future<List<dynamic>> fetchTrending() async {
    final response = await DioHelper.getData(
      url: "$_baseUrl/search/trending",
    );
    return response.data['coins'];
  }

  Future<List<dynamic>> fetchMarkets() async {
    final response = await DioHelper.getData(
        url: "$_baseUrl/coins/markets",
        query: {
          "vs_currency": "usd",
          "per_page": 100,
          "page": 1,
          "sparkline": true,
        }
    );
    return response.data;
  }

  Future<List<dynamic>> fetchMarketsByIds(List<String> ids) async {
    final response = await DioHelper.getData(
      url: "$_baseUrl/coins/markets",
      query: {
        'vs_currency': 'usd',
        'ids': ids.join(','),
        'sparkline': true,
      },
    );
    return response.data;
  }
}