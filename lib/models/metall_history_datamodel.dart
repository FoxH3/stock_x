// ignore_for_file: non_constant_identifier_names

class GoldHisInfo {
  String metal, currency;
  double price,
      price_gram_24k,
      price_gram_22k,
      price_gram_21k,
      price_gram_20k,
      price_gram_18k;
  int year;
  GoldHisInfo(
      {required this.year,
      required this.metal,
      required this.currency,
      required this.price,
      required this.price_gram_24k,
      required this.price_gram_22k,
      required this.price_gram_21k,
      required this.price_gram_20k,
      required this.price_gram_18k});

  factory GoldHisInfo.fromJson(Map<String, dynamic> infoJson) {
    return GoldHisInfo(
      year: infoJson['year'] ?? "",
      metal: infoJson['metal'] ?? "",
      currency: infoJson['currency'] ?? "",
      price: infoJson['price'] ?? "",
      price_gram_24k: infoJson['price_gram_24k'] ?? "",
      price_gram_22k: infoJson['price_gram_22k'] ?? "",
      price_gram_21k: infoJson['price_gram_21k'] ?? "",
      price_gram_20k: infoJson['price_gram_20k'] ?? "",
      price_gram_18k: infoJson['price_gram_18k'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "year": year,
      "metal": metal,
      "currency": currency,
      "price": price,
      "price_gram_24k": price_gram_24k,
      "price_gram_22k": price_gram_22k,
      "price_gram_21k": price_gram_21k,
      "price_gram_20k": price_gram_20k,
      "price_gram_18k": price_gram_18k,
    };
  }
}

class SilverHisInfo {
  String metal, currency;
  double price,
      price_gram_24k,
      price_gram_22k,
      price_gram_21k,
      price_gram_20k,
      price_gram_18k;
  int year;
  SilverHisInfo(
      {required this.year,
      required this.metal,
      required this.currency,
      required this.price,
      required this.price_gram_24k,
      required this.price_gram_22k,
      required this.price_gram_21k,
      required this.price_gram_20k,
      required this.price_gram_18k});

  factory SilverHisInfo.fromJson(Map<String, dynamic> infoJson) {
    return SilverHisInfo(
      year: infoJson['year'] ?? "",
      metal: infoJson['metal'] ?? "",
      currency: infoJson['currency'] ?? "",
      price: infoJson['price'] ?? "",
      price_gram_24k: infoJson['price_gram_24k'] ?? "",
      price_gram_22k: infoJson['price_gram_22k'] ?? "",
      price_gram_21k: infoJson['price_gram_21k'] ?? "",
      price_gram_20k: infoJson['price_gram_20k'] ?? "",
      price_gram_18k: infoJson['price_gram_18k'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "year": year,
      "metal": metal,
      "currency": currency,
      "price": price,
      "price_gram_24k": price_gram_24k,
      "price_gram_22k": price_gram_22k,
      "price_gram_21k": price_gram_21k,
      "price_gram_20k": price_gram_20k,
      "price_gram_18k": price_gram_18k,
    };
  }
}
