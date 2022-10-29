import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_x/models/metall_data_model.dart';
import 'package:stock_x/models/metall_history_datamodel.dart';
import 'package:stock_x/models/stock_data_model.dart';

String apiKey = "goldapi-4z05ttl9lberr1-io";

Future<dynamic> fetchData() async {
  List<MetalInfo> goldInfo = [];
  List<MetalInfo> silverInfo = [];
  SharedPreferences prefs = await SharedPreferences.getInstance();

  final goldResponse = await http.get(
      Uri.parse('https://www.goldapi.io/api/XAU/EUR'),
      headers: <String, String>{
        'x-access-token': apiKey,
        "Content-Type": "application/json"
      });

  final silverResponse = await http.get(
      Uri.parse('https://www.goldapi.io/api/XAG/EUR'),
      headers: <String, String>{
        'x-access-token': apiKey,
        "Content-Type": "application/json"
      });

  if (goldResponse.statusCode == 200 && silverResponse.statusCode == 200) {
    String goldResponseBody = goldResponse.body;
    var goldResponseJSON = json.decode(goldResponseBody);

    String silverResponseBody = silverResponse.body;
    var silverResponseJSON = json.decode(silverResponseBody);

    goldInfo.add(MetalInfo(
      metal: goldResponseJSON['metal'],
      currency: goldResponseJSON['currency'],
      exchange: goldResponseJSON['exchange'],
      ask: goldResponseJSON['ask'],
      bid: goldResponseJSON['bid'],
      zahlSteigung: goldResponseJSON['ch'],
      prozentSteigung: goldResponseJSON['chp'],
      price_gram_24k: goldResponseJSON['price_gram_24k'],
      price_gram_22k: goldResponseJSON['price_gram_22k'],
      price_gram_21k: goldResponseJSON['price_gram_21k'],
      price_gram_20k: goldResponseJSON['price_gram_20k'],
      price_gram_18k: goldResponseJSON['price_gram_18k'],
    ));

    silverInfo.add(MetalInfo(
      metal: silverResponseJSON['metal'],
      currency: silverResponseJSON['currency'],
      exchange: silverResponseJSON['exchange'],
      ask: silverResponseJSON['ask'],
      bid: silverResponseJSON['bid'],
      zahlSteigung: silverResponseJSON['ch'],
      prozentSteigung: silverResponseJSON['chp'],
      price_gram_24k: silverResponseJSON['price_gram_24k'],
      price_gram_22k: silverResponseJSON['price_gram_22k'],
      price_gram_21k: silverResponseJSON['price_gram_21k'],
      price_gram_20k: silverResponseJSON['price_gram_20k'],
      price_gram_18k: silverResponseJSON['price_gram_18k'],
    ));

    var goldjson = jsonEncode(goldInfo);
    var silverjson = jsonEncode(silverInfo);

    await prefs.setString('goldInfo', goldjson);
    await prefs.setString('silverInfo', silverjson);
  } else {
    throw Exception('Fehler beim laden die Daten');
  }
}

Future<dynamic> fetchAktienData() async {
  List<StockInfo> stockInfo = [];
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> companySymbol = [
    "DT",
    "DPW",
    "db",
    "ALV",
    // "pfe",
    // "ard",
    // "MA",
    // "v",
    //diese Daten werden aus API Calls Einschränkungen nicht geholt

    // "nke",
    // "fdx",
    // "ups",
    // "abnb",
    // "nflx",
    // "u",
    // "gme",
    // "swch",
    // "gps",
    // "ko",
    // "sbux",
    // "MCD"
  ];
  List<String> companyName = [
    "Deutsche Telekom",
    "Deutsche Post",
    "Deutsche Bank",
    "Allianz",
    // "Pfizer",
    // "ard fernser",
    // "MASTERCARD",
    // "visa",
    //diese Daten werden aus API Calls Einschränkungen nicht geholt

    // "Nike",
    // "Fedex",
    // "ups",
    // "airbnb",
    // "Netflix",
    // "unity software",
    // "gamestop",
    // "switch",
    // "gap",
    // "coca cola",
    // "Starbox",
    // "macdonlads"
  ];

  for (int i = 0; i < companySymbol.length; i++) {
    final stockRes = await http.get(
      Uri.parse(
          "https://api.twelvedata.com/time_series?apikey=808a6be5a73941e588eb3b134f92f0ed&technicalIndicator=ad&interval=1min&symbol=${companySymbol[i]}&country=us&exchange=nyse&type=stock&outputsize=1&format=JSON"),
    );
    if (stockRes.statusCode == 200 && stockRes.statusCode == 200) {
      String stockResponseBody = stockRes.body;
      var stockResponseJSON = json.decode(stockResponseBody);

      stockInfo.add(StockInfo(
        name: companyName[i],
        symbol: stockResponseJSON['meta']['symbol'],
        currency: stockResponseJSON['meta']['currency'],
        exchange_timezone: stockResponseJSON['meta']['exchange_timezone'],
        exchange: stockResponseJSON['meta']['exchange'],
        datetime: stockResponseJSON['values'][0]['datetime'],
        open: stockResponseJSON['values'][0]['open'],
        high: stockResponseJSON['values'][0]['high'],
        low: stockResponseJSON['values'][0]['low'],
        close: stockResponseJSON['values'][0]['close'],
        volume: stockResponseJSON['values'][0]['volume'],
      ));
    }
  }
  var stockJson = jsonEncode(stockInfo);
  await prefs.setString('stockInfo', stockJson);
}

Future<dynamic> fetchMetallHistData() async {
  List<GoldHisInfo> goldHistory = [];
  List<SilverHisInfo> silverHistory = [];
  List<String> date = [
    "20190101",
    "20200101",
    "20210101",
    "20220101",
  ];
  List<int> years = [2019, 2020, 2021, 2022];
  SharedPreferences prefs = await SharedPreferences.getInstance();

  if (prefs.getString('goldHistory') == null &&
      prefs.getString('silverHistory') == null) {
    for (int i = 0; i < date.length; i++) {
      final goldResponse = await http.get(
          Uri.parse('https://www.goldapi.io/api/XAU/EUR/${date[i]}'),
          headers: <String, String>{
            'x-access-token': apiKey,
            "Content-Type": "application/json"
          });
      final silverResponse = await http.get(
          Uri.parse('https://www.goldapi.io/api/XAG/EUR/${date[i]}'),
          headers: <String, String>{
            'x-access-token': apiKey,
            "Content-Type": "application/json"
          });

      if (goldResponse.statusCode == 200 && silverResponse.statusCode == 200) {
        String goldResponseBody = goldResponse.body;
        var goldResponseJSON = json.decode(goldResponseBody);

        String silverResponseBody = silverResponse.body;
        var silverResponseJSON = json.decode(silverResponseBody);

        goldHistory.add(GoldHisInfo(
          year: years[i],
          metal: goldResponseJSON['metal'],
          currency: goldResponseJSON['currency'],
          price: goldResponseJSON['price'],
          price_gram_24k: goldResponseJSON['price_gram_24k'],
          price_gram_22k: goldResponseJSON['price_gram_22k'],
          price_gram_21k: goldResponseJSON['price_gram_21k'],
          price_gram_20k: goldResponseJSON['price_gram_20k'],
          price_gram_18k: goldResponseJSON['price_gram_18k'],
        ));

        silverHistory.add(SilverHisInfo(
          year: years[i],
          metal: silverResponseJSON['metal'],
          currency: silverResponseJSON['currency'],
          price: silverResponseJSON['price'],
          price_gram_24k: silverResponseJSON['price_gram_24k'],
          price_gram_22k: silverResponseJSON['price_gram_22k'],
          price_gram_21k: silverResponseJSON['price_gram_21k'],
          price_gram_20k: silverResponseJSON['price_gram_20k'],
          price_gram_18k: silverResponseJSON['price_gram_18k'],
        ));

        var goldjson = jsonEncode(goldHistory);
        var silverjson = jsonEncode(silverHistory);

        await prefs.setString('goldHistory', goldjson);
        await prefs.setString('silverHistory', silverjson);
      } else {
        throw Exception('Failed to load data');
      }
    }
  } else {
    return;
  }
}
