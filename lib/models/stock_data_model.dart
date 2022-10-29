// ignore_for_file: non_constant_identifier_names

class StockInfo {
  //modal class for Person object
  String name,
      symbol,
      currency,
      exchange_timezone,
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
    required this.exchange_timezone,
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
      exchange_timezone: infoJson['exchange_timezone'] ?? "",
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
      "exchange_timezone": exchange_timezone,
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
