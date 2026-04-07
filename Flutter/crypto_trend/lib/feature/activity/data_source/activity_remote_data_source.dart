class ActivityRemoteDataSource {
  Future<List<dynamic>> fetchUserActivity() async {
    await Future.delayed(const Duration(seconds: 2));

    // Simulated Response
    return [
      {
        "symbol": "BTCBUSD",
        "orderId": 1,
        "price": "2652.00",
        "origQty": "0.49975",
        "executedQty": "0.49975",
        "status": "FILLED",
        "timeInForce": "GTC",
        "type": "LIMIT",
        "side": "BUY",
        "time": 1627879166000,
      },
      {
        "symbol": "BTCBUSD",
        "orderId": 2,
        "price": "2652.00",
        "origQty": "0.49975",
        "executedQty": "0.00000",
        "status": "CANCELED",
        "timeInForce": "GTC",
        "type": "LIMIT",
        "side": "SELL",
        "time": 1627879166000,
      },
      {
        "symbol": "ETHUSDT",
        "orderId": 3,
        "price": "1850.50",
        "origQty": "1.50000",
        "executedQty": "1.50000",
        "status": "FILLED",
        "timeInForce": "GTC",
        "type": "MARKET",
        "side": "BUY",
        "time": 1627965566000,
      }
    ];
  }
}