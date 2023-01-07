/*
modelClass für Aktien informationen
*/

class StockInfo {
  String name,
      symbol,
      currency,
      exchangeTimezone,
      exchange,
      datetime,
      open,
      high,
      low,
      close,
      volume;

  StockInfo({
    required this.name,
    required this.symbol,
    required this.currency,
    required this.exchangeTimezone,
    required this.exchange,
    required this.datetime,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.volume,
  });

  factory StockInfo.fromJson(Map<String, dynamic> infoJson) {
    return StockInfo(
      name: infoJson['name'] ?? "",
      symbol: infoJson['symbol'] ?? "",
      currency: infoJson['currency'] ?? "",
      exchangeTimezone: infoJson['exchange_timezone'] ?? "",
      exchange: infoJson['exchange'] ?? "",
      datetime: infoJson['datetime'] ?? "",
      open: infoJson['open'] ?? "",
      high: infoJson['high'] ?? "",
      low: infoJson['low'] ?? "",
      close: infoJson['close'] ?? "",
      volume: infoJson['volume'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "symbol": symbol,
      "currency": currency,
      "exchange_timezone": exchangeTimezone,
      "exchange": exchange,
      "datetime": datetime,
      "open": open,
      "high": high,
      "low": low,
      "close": close,
      "volume": volume,
    };
  }
}
