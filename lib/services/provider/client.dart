import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:stock_x/models/metall_data_model.dart';
import 'package:stock_x/models/metall_history_datamodel.dart';
import 'package:stock_x/models/stock_data_model.dart';
import 'package:stock_x/models/stock_history_model.dart';

/*
Die Datei beinhaltet mehere die für die
Datafetching zuständig sind sowie das 
Data in der DB zu puschen
*/

late String apiKey;
late String apiKey1;
late String apiKey2;

List<String> companyNr = [
  "1.unternehmen",
  "2.unternehmen",
  "3.unternehmen",
  "4.unternehmen",
];
List<String> jahren = [
  "1.jahr",
  "2.jahr",
  "3.jahr",
  "4.jahr",
];

//daten aus der Api holen und die daten in Listen
//speichern anschließend in der DB laden.
Future<dynamic> fetchData(context) async {
  var apiSnapshot = await FirebaseFirestore.instance
      .collection('lizenz keys')
      .doc("Edelmetalle Api")
      .get();

  if (apiSnapshot.exists) {
    Map<String, dynamic>? data = apiSnapshot.data();

    apiKey = data!["Api key"];
  }
  var aktienApiSnapshot = await FirebaseFirestore.instance
      .collection('lizenz keys')
      .doc("Aktien Api")
      .get();

  if (aktienApiSnapshot.exists) {
    Map<String, dynamic>? data = aktienApiSnapshot.data();

    apiKey1 = data!["Api key1"];
    apiKey2 = data["Api key2"];
  }

  List<MetalInfo> goldInfo = [];
  List<MetalInfo> silverInfo = [];
  List<StockInfo> stockInfo = [];

  List<String> companySymbol = [];
  List<String> companyName = [];

  List<GoldHisInfo> goldHistory = [];
  List<SilverHisInfo> silverHistory = [];
  List<String> date = [];
  List<int> years = [];

  companyName = await getList("Aktien Unternehmen", companyNr);
  companySymbol = await getList("Aktien Unternehmen Symbol", companyNr);
  date = await getList("Edelmetall jahren", jahren);
  years = await getYears("Jahren für die App", jahren);

  DateTime dateToday = DateTime.now();
  String time =
      "${DateFormat('dd-MM-yyyy').format(DateTime.now())} um: ${dateToday.hour}:${dateToday.minute}";

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

//überprüft ob respose == 200
  if (goldResponse.statusCode == 200 && silverResponse.statusCode == 200) {
    String goldResponseBody = goldResponse.body;
    var goldResponseJSON = json.decode(goldResponseBody);

    String silverResponseBody = silverResponse.body;
    var silverResponseJSON = json.decode(silverResponseBody);
//daten in listen speichern
    goldInfo.add(MetalInfo(
      time: time,
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
      time: time,
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
  } else {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Fehler beim laden die Daten"),
      backgroundColor: Colors.red,
    ));
    throw Exception('Fehler beim laden die Daten');
  }

  for (int i = 0; i < companySymbol.length; i++) {
    final stockRes = await http.get(
      Uri.parse(apiKey1 + companySymbol[i] + apiKey2),
    );

    if (stockRes.statusCode == 200 && stockRes.statusCode == 200) {
      String stockResponseBody = stockRes.body;
      var stockResponseJSON = json.decode(stockResponseBody);

      stockInfo.add(StockInfo(
        name: companyName[i],
        symbol: stockResponseJSON['meta']['symbol'],
        currency: stockResponseJSON['meta']['currency'],
        exchangeTimezone: stockResponseJSON['meta']['exchange_timezone'],
        exchange: stockResponseJSON['meta']['exchange'],
        datetime: stockResponseJSON['values'][0]['datetime'],
        open: stockResponseJSON['values'][0]['open'],
        high: stockResponseJSON['values'][0]['high'],
        low: stockResponseJSON['values'][0]['low'],
        close: stockResponseJSON['values'][0]['close'],
        volume: stockResponseJSON['values'][0]['volume'],
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Fehler beim laden die Daten"),
        backgroundColor: Colors.red,
      ));
      throw Exception('Fehler beim laden die Daten');
    }
  }

  var goldDocSnapshot = await FirebaseFirestore.instance
      .collection('stockData')
      .doc("Gold History")
      .get();
  var silberDocSnapshot = await FirebaseFirestore.instance
      .collection('stockData')
      .doc("Silber History")
      .get();

  if (goldDocSnapshot.exists && silberDocSnapshot.exists) {
    var docSnapshot2 = await FirebaseFirestore.instance
        .collection('stockData')
        .doc("Gold History")
        .get();
    if (docSnapshot2.exists) {
      Map<String, dynamic>? data = docSnapshot2.data();
      goldHistory.add(GoldHisInfo(price: data?["1.preis"], year: years[0]));
      goldHistory.add(GoldHisInfo(price: data?["2.preis"], year: years[1]));
      goldHistory.add(GoldHisInfo(price: data?["3.preis"], year: years[2]));
      goldHistory.add(GoldHisInfo(price: data?["4.preis"], year: years[3]));
    }

    var docSnapshot3 = await FirebaseFirestore.instance
        .collection('stockData')
        .doc("Silber History")
        .get();
    if (docSnapshot3.exists) {
      Map<String, dynamic>? data = docSnapshot3.data();
      silverHistory.add(SilverHisInfo(price: data?["1.preis"], year: years[0]));
      silverHistory.add(SilverHisInfo(price: data?["2.preis"], year: years[1]));
      silverHistory.add(SilverHisInfo(price: data?["3.preis"], year: years[2]));
      silverHistory.add(SilverHisInfo(price: data?["4.preis"], year: years[3]));
    }
  } else {
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
          price: goldResponseJSON['price'],
        ));

        silverHistory.add(SilverHisInfo(
          year: years[i],
          price: silverResponseJSON['price'],
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Fehler beim laden die Daten"),
          backgroundColor: Colors.red,
        ));
        throw Exception('Fehler beim laden die Daten');
      }
    }
  }

  if (goldInfo.isNotEmpty &&
      silverInfo.isNotEmpty &&
      stockInfo.isNotEmpty &&
      goldHistory.isNotEmpty &&
      silverHistory.isNotEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Daten erfolgreich Aktualisiert"),
      backgroundColor: Colors.green,
    ));
    pushData(goldInfo, silverInfo, stockInfo, goldHistory, silverHistory);
  } else {
    fetchData(context);
  }
}

Future<void> pushData(List goldInfo, List silverInfo, List stockInfo,
    List goldHistory, List silverHistory) async {
  List stocksItems = [];

  stocksItems = await getList("Aktien Unternehmen", companyNr);

  List metallItems = [
    "time",
    "metal",
    "currency",
    "exchange",
    "ask",
    "bid",
    "ch",
    "chp",
    "price_gram_24k",
    "price_gram_22k",
    "price_gram_21k",
    "price_gram_20k",
    "price_gram_18k",
  ];

  List stockItems = [
    "name",
    "symbol",
    "currency",
    "exchange_timezone",
    "exchange",
    "datetime",
    "open",
    "high",
    "low",
    "close",
    "volume",
  ];
  List<String> historyPrice = [
    "1.preis",
    "2.preis",
    "3.preis",
    "4.preis",
  ];
  await FirebaseFirestore.instance.collection('stockData').doc("Gold").set({
    metallItems[0]: goldInfo[0].time,
    metallItems[1]: goldInfo[0].metal,
    metallItems[2]: goldInfo[0].currency,
    metallItems[3]: goldInfo[0].exchange,
    metallItems[4]: goldInfo[0].ask,
    metallItems[5]: goldInfo[0].bid,
    metallItems[6]: goldInfo[0].prozentSteigung,
    metallItems[7]: goldInfo[0].zahlSteigung,
    metallItems[8]: goldInfo[0].price_gram_24k,
    metallItems[9]: goldInfo[0].price_gram_22k,
    metallItems[10]: goldInfo[0].price_gram_21k,
    metallItems[11]: goldInfo[0].price_gram_20k,
    metallItems[12]: goldInfo[0].price_gram_18k,
  });

  await FirebaseFirestore.instance.collection('stockData').doc("Silber").set({
    metallItems[0]: silverInfo[0].time,
    metallItems[1]: silverInfo[0].metal,
    metallItems[2]: silverInfo[0].currency,
    metallItems[3]: silverInfo[0].exchange,
    metallItems[4]: silverInfo[0].ask,
    metallItems[5]: silverInfo[0].bid,
    metallItems[6]: silverInfo[0].prozentSteigung,
    metallItems[7]: silverInfo[0].zahlSteigung,
    metallItems[8]: silverInfo[0].price_gram_24k,
    metallItems[9]: silverInfo[0].price_gram_22k,
    metallItems[10]: silverInfo[0].price_gram_21k,
    metallItems[11]: silverInfo[0].price_gram_20k,
    metallItems[12]: silverInfo[0].price_gram_18k,
  });

  for (int i = 0; i < stocksItems.length; i++) {
    await FirebaseFirestore.instance
        .collection('stockData')
        .doc(stocksItems[i])
        .set({
      stockItems[0]: stockInfo[i].name,
      stockItems[1]: stockInfo[i].symbol,
      stockItems[2]: stockInfo[i].currency,
      stockItems[3]: stockInfo[i].exchange_timezone,
      stockItems[4]: stockInfo[i].exchange,
      stockItems[5]: stockInfo[i].datetime,
      stockItems[6]: stockInfo[i].open,
      stockItems[7]: stockInfo[i].high,
      stockItems[8]: stockInfo[i].low,
      stockItems[9]: stockInfo[i].close,
      stockItems[10]: stockInfo[i].volume,
    });
  }

  await FirebaseFirestore.instance
      .collection('stockData')
      .doc("Gold History")
      .set({
    historyPrice[0]: goldHistory[0].price,
    historyPrice[1]: goldHistory[1].price,
    historyPrice[2]: goldHistory[2].price,
    historyPrice[3]: goldHistory[3].price,
  });

  await FirebaseFirestore.instance
      .collection('stockData')
      .doc("Silber History")
      .set({
    historyPrice[0]: silverHistory[0].price,
    historyPrice[1]: silverHistory[1].price,
    historyPrice[2]: silverHistory[2].price,
    historyPrice[3]: silverHistory[3].price,
  });
}

//Die Unternehmen abkürzung werden aus der DB geholt
Future<List<String>> getList(String docName, List list) async {
  List<String> newList = [];
  var companySnapshot = await FirebaseFirestore.instance
      .collection('lizenz keys')
      .doc(docName)
      .get();

  if (companySnapshot.exists) {
    Map<String, dynamic>? data = companySnapshot.data();

    for (int i = 0; i < data!.length; i++) {
      newList.add(data[list[i]]);
    }
  }
  return newList;
}

//Die jahren für die Historie werden aus der DB geholt
Future<List<int>> getYears(String docName, List list) async {
  List<int> newList = [];
  var companySnapshot = await FirebaseFirestore.instance
      .collection('lizenz keys')
      .doc(docName)
      .get();

  if (companySnapshot.exists) {
    Map<String, dynamic>? data = companySnapshot.data();

    for (int i = 0; i < data!.length; i++) {
      newList.add(data[list[i]]);
    }
  }
  return newList;
}

//Detusche Telekom Hisorie Daten aus der API
//geholt -> in Listen gepsiechert -> in der DB geladen
fetchDtHistory() async {
  List<StockHisInfo> stockHisInfo = [];
  final stockRes = await http.get(
    Uri.parse(
        "https://api.twelvedata.com/time_series?apikey=808a6be5a73941e588eb3b134f92f0ed&interval=1month&symbol=DT&country=US&exchange=NYSE&type=stock&timezone=exchange&start_date=2021-12-01 16:51:00&end_date=2022-12-07 16:51:00&format=JSON"),
  );

  if (stockRes.statusCode == 200) {
    String stockResponseBody = stockRes.body;

    var stockResponseJSON = json.decode(stockResponseBody);
    for (int i = 0; i < 11; i++) {
      DateTime replaced =
          DateTime.parse(stockResponseJSON['values'][i]["datetime"]);
      stockHisInfo.add(StockHisInfo(
          name: "Deutsche Telekom",
          datetime: replaced,
          open: double.parse(stockResponseJSON['values'][i]["open"]),
          high: double.parse(stockResponseJSON['values'][i]["high"]),
          low: double.parse(stockResponseJSON['values'][i]["low"]),
          close: double.parse(stockResponseJSON['values'][i]["close"])));
    }
    for (int i = 0; i < stockHisInfo.length; i++) {
      await FirebaseFirestore.instance
          .collection('Deutsche Telekom History')
          .doc("History data: $i")
          .set({
        "dateTime": stockHisInfo[i].datetime.toString(),
        "open": stockHisInfo[i].open.toString(),
        "high": stockHisInfo[i].high.toString(),
        "low": stockHisInfo[i].low.toString(),
        "close": stockHisInfo[i].close.toString()
      });
    }
  }
}

//Detusche Post Hisorie Daten aus der API
//geholt -> in Listen gepsiechert -> in der DB geladen
fetchDpHistory() async {
  List<StockHisInfo> stockHisInfo = [];
  final stockRes = await http.get(
    Uri.parse(
        "https://api.twelvedata.com/time_series?apikey=808a6be5a73941e588eb3b134f92f0ed&interval=1month&symbol=dpw&country=US&exchange=NYSE&type=stock&timezone=exchange&start_date=2021-12-01 16:51:00&end_date=2022-12-07 16:51:00&format=JSON "),
  );

  if (stockRes.statusCode == 200) {
    String stockResponseBody = stockRes.body;

    var stockResponseJSON = json.decode(stockResponseBody);
    for (int i = 0; i < stockResponseJSON.length; i++) {
      DateTime replaced =
          DateTime.parse(stockResponseJSON['values'][i]["datetime"]);
      stockHisInfo.add(StockHisInfo(
          name: "Deutsche Post",
          datetime: replaced,
          open: double.parse(stockResponseJSON['values'][i]["open"]),
          high: double.parse(stockResponseJSON['values'][i]["high"]),
          low: double.parse(stockResponseJSON['values'][i]["low"]),
          close: double.parse(stockResponseJSON['values'][i]["close"])));
    }

    for (int i = 0; i < stockHisInfo.length; i++) {
      await FirebaseFirestore.instance
          .collection('Deutsche Post History')
          .doc("History data: $i")
          .set({
        "dateTime": stockHisInfo[i].datetime.toString(),
        "open": stockHisInfo[i].open.toString(),
        "high": stockHisInfo[i].high.toString(),
        "low": stockHisInfo[i].low.toString(),
        "close": stockHisInfo[i].close.toString()
      });
    }
  }
}

//Detusche Bank Hisorie Daten aus der API
//geholt -> in Listen gepsiechert -> in der DB geladen
fetchDbHistory() async {
  List<StockHisInfo> stockHisInfo = [];
  final stockRes = await http.get(
    Uri.parse(
        "https://api.twelvedata.com/time_series?apikey=808a6be5a73941e588eb3b134f92f0ed&interval=1month&symbol=db&country=US&exchange=NYSE&type=stock&timezone=exchange&start_date=2021-12-01 16:51:00&end_date=2022-12-07 16:51:00&format=JSON"),
  );

  if (stockRes.statusCode == 200) {
    String stockResponseBody = stockRes.body;

    var stockResponseJSON = json.decode(stockResponseBody);
    for (int i = 0; i < 11; i++) {
      DateTime replaced =
          DateTime.parse(stockResponseJSON['values'][i]["datetime"]);
      stockHisInfo.add(StockHisInfo(
          name: "Deutsche Bank",
          datetime: replaced,
          open: double.parse(stockResponseJSON['values'][i]["open"]),
          high: double.parse(stockResponseJSON['values'][i]["high"]),
          low: double.parse(stockResponseJSON['values'][i]["low"]),
          close: double.parse(stockResponseJSON['values'][i]["close"])));
    }

    for (int i = 0; i < stockHisInfo.length; i++) {
      await FirebaseFirestore.instance
          .collection('Deutsche Bank History')
          .doc("History data: $i")
          .set({
        "dateTime": stockHisInfo[i].datetime.toString(),
        "open": stockHisInfo[i].open.toString(),
        "high": stockHisInfo[i].high.toString(),
        "low": stockHisInfo[i].low.toString(),
        "close": stockHisInfo[i].close.toString()
      });
    }
  }
}

//Allianz Hisorie Daten aus der API
//geholt -> in Listen gepsiechert -> in der DB geladen
fetchAlHistory() async {
  List<StockHisInfo> stockHisInfo = [];
  final stockRes = await http.get(
    Uri.parse(
        "https://api.twelvedata.com/time_series?apikey=808a6be5a73941e588eb3b134f92f0ed&interval=1month&symbol=ALV&country=US&exchange=NYSE&type=stock&timezone=exchange&start_date=2021-12-01 16:51:00&end_date=2022-12-07 16:51:00&format=JSON"),
  );

  if (stockRes.statusCode == 200) {
    String stockResponseBody = stockRes.body;

    var stockResponseJSON = json.decode(stockResponseBody);
    for (int i = 0; i < 11; i++) {
      DateTime replaced =
          DateTime.parse(stockResponseJSON['values'][i]["datetime"]);
      stockHisInfo.add(StockHisInfo(
          name: "Allianz",
          datetime: replaced,
          open: double.parse(stockResponseJSON['values'][i]["open"]),
          high: double.parse(stockResponseJSON['values'][i]["high"]),
          low: double.parse(stockResponseJSON['values'][i]["low"]),
          close: double.parse(stockResponseJSON['values'][i]["close"])));
    }

    for (int i = 0; i < stockHisInfo.length; i++) {
      await FirebaseFirestore.instance
          .collection('Allianz History')
          .doc("History data: $i")
          .set({
        "dateTime": stockHisInfo[i].datetime.toString(),
        "open": stockHisInfo[i].open.toString(),
        "high": stockHisInfo[i].high.toString(),
        "low": stockHisInfo[i].low.toString(),
        "close": stockHisInfo[i].close.toString()
      });
    }
  }
}
