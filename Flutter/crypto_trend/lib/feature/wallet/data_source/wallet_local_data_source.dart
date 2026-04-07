import 'package:crypto_trend/core/local/db_helper.dart';

class WalletLocalDataSource {
  Future<int> addCoinToWallet(int userId, String symbol, double price, double amount, String icon) async {
    final db = await DbHelper.instance.database;
    return await db.insert('wallet', {
      'user_id': userId,
      'symbol': symbol, 
      'price': price, 
      'amount': amount, 
      'icon': icon
    });
  }

  Future<List<Map<String, dynamic>>> getWalletCoins(int userId) async {
    final db = await DbHelper.instance.database;
    return await db.query('wallet', where: 'user_id = ?', whereArgs: [userId]);
  }

  Future<int> deleteCoin(int id) async {
    final db = await DbHelper.instance.database;
    return await db.delete('wallet', where: 'id = ?', whereArgs: [id]);
  }
}