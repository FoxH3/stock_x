// ignore_for_file: non_constant_identifier_names

/*
modelClass für edelmetall informationen
*/
class MetalInfo {
  String time, metal, currency, exchange;
  double zahlSteigung,
      prozentSteigung,
      price_gram_24k,
      price_gram_22k,
      price_gram_21k,
      price_gram_20k,
      price_gram_18k;
  // ignore: prefer_typing_uninitialized_variables
  var ask, bid;
  MetalInfo(
      {required this.time,
      required this.metal,
      required this.currency,
      required this.exchange,
      required this.ask,
      required this.bid,
      required this.zahlSteigung,
      required this.prozentSteigung,
      required this.price_gram_24k,
      required this.price_gram_22k,
      required this.price_gram_21k,
      required this.price_gram_20k,
      required this.price_gram_18k});

  factory MetalInfo.fromJson(Map<String, dynamic> infoJson) {
    return MetalInfo(
      time: infoJson['time'] ?? "",
      metal: infoJson['metal'] ?? "",
      currency: infoJson['currency'] ?? "",
      exchange: infoJson['exchange'] ?? "",
      ask: infoJson['ask'] ?? "",
      bid: infoJson['bid'] ?? "",
      zahlSteigung: infoJson['ch'] ?? "",
      prozentSteigung: infoJson['chp'] ?? "",
      price_gram_24k: infoJson['price_gram_24k'] ?? "",
      price_gram_22k: infoJson['price_gram_22k'] ?? "",
      price_gram_21k: infoJson['price_gram_21k'] ?? "",
      price_gram_20k: infoJson['price_gram_20k'] ?? "",
      price_gram_18k: infoJson['price_gram_18k'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "time": time,
      "metal": metal,
      "currency": currency,
      "exchange": exchange,
      "ask": ask,
      "bid": bid,
      "ch": zahlSteigung,
      "chp": prozentSteigung,
      "price_gram_24k": price_gram_24k,
      "price_gram_22k": price_gram_22k,
      "price_gram_21k": price_gram_21k,
      "price_gram_20k": price_gram_20k,
      "price_gram_18k": price_gram_18k,
    };
  }
}
