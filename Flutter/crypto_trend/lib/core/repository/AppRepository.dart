import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../feature/activity/data_source/activity_remote_data_source.dart';
import '../../feature/auth/data_source/Auth_local_data_source.dart';
import '../../feature/home/data_source/home_remote_data_source.dart';
import '../../feature/market/data_source/market_remote_data_source.dart';
import '../../feature/wallet/data_source/wallet_local_data_source.dart';

class AppRepository {
  final AuthLocalDataSource authLocal;
  final WalletLocalDataSource walletLocal;
  final HomeRemoteDataSource homeRemote;
  final MarketRemoteDataSource marketRemote;
  final ActivityRemoteDataSource activityRemote;
  final SharedPreferences prefs;
  final FlutterSecureStorage secureStorage;

  AppRepository({
    required this.authLocal,
    required this.walletLocal,
    required this.homeRemote,
    required this.marketRemote,
    required this.activityRemote,
    required this.prefs,
    required this.secureStorage,
  });

  Future<List<dynamic>> getTrendingCoins() => homeRemote.fetchTrending();
  Future<List<dynamic>> getMarketsByIds(List<String> ids) => homeRemote.fetchMarketsByIds(ids);

  Future<List<dynamic>> getMarkets() => marketRemote.fetchMarkets();
  Future<List<dynamic>> getBinanceTickers() => marketRemote.fetchTickers();

  Future<List<dynamic>> getUserActivity() => activityRemote.fetchUserActivity();

  Future<int> addCoinToWallet(String symbol, double price, double amount, String icon) {
    final userId = getUserId();
    return walletLocal.addCoinToWallet(userId, symbol, price, amount, icon);
  }
  Future<List<Map<String, dynamic>>> getWalletCoins() {
    final userId = getUserId();
    return walletLocal.getWalletCoins(userId);
  }
  Future<int> removeCoinFromWallet(int id) {
    return walletLocal.deleteCoin(id);
  }

  Future<Map<String, dynamic>?> login(String email, String password) {
    return authLocal.loginUser(email, password);
  }
  Future<int> signUp(String email, String password, String username) {
    return authLocal.signUp(email, password, username);
  }

  // --- Shared Preferences
  Future<void> saveUserSession(int userId, String username) async {
    await prefs.setBool('isLoggedIn', true);
    await prefs.setInt('userId', userId);
    await prefs.setString('username', username);
  }

  int getUserId() {
    return prefs.getInt('userId') ?? -1;
  }

  bool isLoggedIn() {
    return prefs.getBool('isLoggedIn') ?? false;
  }

  String getUsername() {
    return prefs.getString('username') ?? 'Unknown User';
  }

  Future<void> logout() async {
    await prefs.clear();
  }

  Future<void> saveSecureCredentials(String email, String password) async {
    await secureStorage.write(key: 'email', value: email);
    await secureStorage.write(key: 'password', value: password);
  }

  Future<void> clearSecureCredentials() async {
    await secureStorage.deleteAll();
  }

  Future<Map<String, String?>> getSecureCredentials() async {
    String? email = await secureStorage.read(key: 'email');
    String? password = await secureStorage.read(key: 'password');
    return {'email': email, 'password': password};
  }
}