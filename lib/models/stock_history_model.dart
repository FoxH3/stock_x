/*
modelClass für Aktien Historie informationen
*/
class StockHisInfo {
  //modal class for Person object
  String name;
  DateTime datetime;
  num open, high, low, close;

  StockHisInfo({
    required this.name,
    required this.datetime,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
  });

  factory StockHisInfo.fromJson(Map<String, dynamic> infoJson) {
    return StockHisInfo(
      name: infoJson['name'] ?? "",
      datetime: infoJson['datetime'] ?? "",
      open: infoJson['open'] ?? "",
      high: infoJson['high'] ?? "",
      low: infoJson['low'] ?? "",
      close: infoJson['close'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "datetime": datetime,
      "open": open,
      "high": high,
      "low": low,
      "close": close,
    };
  }
}
