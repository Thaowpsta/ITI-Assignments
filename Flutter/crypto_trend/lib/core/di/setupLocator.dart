import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../feature/activity/data_source/activity_remote_data_source.dart';
import '../../feature/auth/data_source/Auth_local_data_source.dart';
import '../../feature/home/data_source/home_remote_data_source.dart';
import '../../feature/market/data_source/market_remote_data_source.dart';
import '../../feature/wallet/data_source/wallet_local_data_source.dart';
import '../repository/AppRepository.dart';

late AppRepository appRepository;

Future<void> setupLocator() async {
  final sharedPrefs = await SharedPreferences.getInstance();
  const secureStorage = FlutterSecureStorage();

  final authLocal = AuthLocalDataSource();
  final walletLocal = WalletLocalDataSource();
  final homeRemote = HomeRemoteDataSource();
  final marketRemote = MarketRemoteDataSource();
  final activityRemote = ActivityRemoteDataSource();

  appRepository = AppRepository(
    authLocal: authLocal,
    walletLocal: walletLocal,
    homeRemote: homeRemote,
    marketRemote: marketRemote,
    activityRemote: activityRemote,
    prefs: sharedPrefs,
    secureStorage: secureStorage,
  );
}