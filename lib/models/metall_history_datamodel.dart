/*
modelClass für Gold und Silber historie informationen
*/
class GoldHisInfo {
  double price;
  int year;
  GoldHisInfo({
    required this.year,
    required this.price,
  });

  factory GoldHisInfo.fromJson(Map<String, dynamic> infoJson) {
    return GoldHisInfo(
      year: infoJson['year'] ?? "",
      price: infoJson['price'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "year": year,
      "price": price,
    };
  }
}

class SilverHisInfo {
  double price;
  int year;
  SilverHisInfo({
    required this.year,
    required this.price,
  });

  factory SilverHisInfo.fromJson(Map<String, dynamic> infoJson) {
    return SilverHisInfo(
      year: infoJson['year'] ?? "",
      price: infoJson['price'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "year": year,
      "price": price,
    };
  }
}
