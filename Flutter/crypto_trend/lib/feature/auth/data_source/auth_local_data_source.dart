import 'package:crypto_trend/core/local/db_helper.dart';

class AuthLocalDataSource {
  Future<int> signUp(String email, String password, String username) async {
    final db = await DbHelper.instance.database;
    return await db.insert('users', {
      'email': email, 
      'password': password, 
      'username': username
    });
  }

  Future<Map<String, dynamic>?> loginUser(String email, String password) async {
    final db = await DbHelper.instance.database;
    final result = await db.query(
      'users', 
      where: 'email = ? AND password = ?', 
      whereArgs: [email, password]
    );
    if (result.isNotEmpty) return result.first;
    return null;
  }
}