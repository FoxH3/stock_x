import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_x/models/metall_data_model.dart';
import 'package:stock_x/models/metall_history_datamodel.dart';
import 'package:stock_x/services/provider/client.dart';
import 'package:stock_x/services/provider/encryption.dart';

/*
Die Datei bethoden die für Transatkionen 
auf die Datenbank durchführen.
*/

//EdelMetale History data werden aus der DB Geholt
//und local gespeichert.
Future<String> loadHisDataFromDB() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<GoldHisInfo> goldInfoHistory = [];
  List<SilverHisInfo> silverInfoHistory = [];

  var docSnapshot2 = await FirebaseFirestore.instance
      .collection('stockData')
      .doc("Gold History")
      .get();
  if (docSnapshot2.exists) {
    Map<String, dynamic>? data = docSnapshot2.data();
    goldInfoHistory.add(GoldHisInfo(price: data?["1.preis"], year: 2019));
    goldInfoHistory.add(GoldHisInfo(price: data?["2.preis"], year: 2020));
    goldInfoHistory.add(GoldHisInfo(price: data?["3.preis"], year: 2021));
    goldInfoHistory.add(GoldHisInfo(price: data?["4.preis"], year: 2022));
  }

  var docSnapshot3 = await FirebaseFirestore.instance
      .collection('stockData')
      .doc("Silber History")
      .get();
  if (docSnapshot3.exists) {
    Map<String, dynamic>? data = docSnapshot3.data();
    silverInfoHistory.add(SilverHisInfo(price: data?["1.preis"], year: 2019));
    silverInfoHistory.add(SilverHisInfo(price: data?["2.preis"], year: 2020));
    silverInfoHistory.add(SilverHisInfo(price: data?["3.preis"], year: 2021));
    silverInfoHistory.add(SilverHisInfo(price: data?["4.preis"], year: 2022));
  }

  var goldHisjson = jsonEncode(goldInfoHistory);
  var silverHisjson = jsonEncode(silverInfoHistory);

  await prefs.setString('goldHistory', goldHisjson);
  await prefs.setString('silverHistory', silverHisjson);

  return "";
}

//Methode nimmt user waährung/aktie name und angegebne wert
//chiffriert die daten lädt die in der DB
Future<void> setUserData(String payData, String wert) async {
  try {
    String dataPrice = "${payData}_amount";

    String uid = FirebaseAuth.instance.currentUser!.uid;
    //Daten ändern
    var collection = FirebaseFirestore.instance.collection('userData');

    double newValue = double.parse(wert);
    newValue = newValue.abs(); //Keine Negative zahlen

    collection.doc(uid).update(
        {payData: Encryption.dataCrypt(newValue.toString(), await getKey())});
    collection.doc(uid).update({
      dataPrice: Encryption.dataCrypt(
          await getPrice(payData, newValue), await getKey())
    });
  } catch (e) {
    return;
  }
}

//Methode nimmt user waährung/aktie name und angegebne wert
//bearbeitet die und lädt die durch die setUserData Methode hoch
Future<void> payIn(String payData, String wert) async {
  try {
    String dataPrice = "${payData}_amount";

    String uid = FirebaseAuth.instance.currentUser!.uid;

    var collection = FirebaseFirestore.instance.collection('userData');
    var docSnapshot = await collection.doc(uid).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      String value = data?[payData];

      value = Encryption.dataDeCrypt(await getKey(), value);

      wert = wert.replaceAll(",", ".");

      double oldWert = double.parse(value);
      double neuWert = double.parse(wert);

      double newValue = oldWert + neuWert;

      newValue = newValue.abs();

      setUserData(payData, newValue.toString());

      ///Price set
      setUserData(dataPrice, await getPrice(payData, newValue));
    }
  } catch (e) {
    return;
  }
}

//Methode lifert mir der Aktuelle Kurspreis
//multipliziert mit der von user angegebene
Future<String> getPrice(String payData, double value) async {
  String price = await loadPriceData(payData);

  double newPrice = double.parse(price);

  double priceNewValue = value * newPrice;

  String roundPrice = priceNewValue.toStringAsFixed(2).toString();

  return roundPrice;
}

//methode wird für das Leeren die Wallet verwedent
//diese Setzt alle Werte auf 0
Future<void> removeWallet() async {
  String zero = Encryption.dataCrypt("0", await getKey()).toString();

  List infoList = [
    'A.info',
    "B.info",
    "C.info",
    "D.info",
    "E.info",
    "F.info",
    'G.info',
    "H.info",
    "I.info",
    "J.info",
    "K.info",
    "L.info"
  ];
  List liste = [];
  liste = await getList("Wallet data", infoList);

  String uid = FirebaseAuth.instance.currentUser!.uid;
  try {
    for (int i = 0; i < liste.length; i++) {
      var collection1 = FirebaseFirestore.instance.collection('userData');
      collection1.doc(uid).update({liste[i]: zero});
    }
  } catch (e) {
    return;
  }
}

//Diese Liefet die Aktuellen Preise aus der DB.
Future<String> loadPriceData(String data) async {
  List<MetalInfo> goldInfo = [];
  List<MetalInfo> silverInfo = [];

  if (data == "Gold") {
    var docSnapshot = await FirebaseFirestore.instance
        .collection('stockData')
        .doc("Gold")
        .get();

    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      goldInfo.add(MetalInfo(
        time: data?["time"],
        metal: data?["metal"],
        currency: data?["currency"],
        exchange: data?["exchange"],
        ask: data?["ask"],
        bid: data?["bid"],
        zahlSteigung: data?["ch"],
        prozentSteigung: data?["chp"],
        price_gram_24k: data?["price_gram_24k"],
        price_gram_22k: data?["price_gram_22k"],
        price_gram_21k: data?["price_gram_21k"],
        price_gram_20k: data?["price_gram_20k"],
        price_gram_18k: data?["price_gram_18k"],
      ));
    }

    return goldInfo[0].price_gram_24k.toString();
  }
  if (data == "Silber") {
    var docSnapshot1 = await FirebaseFirestore.instance
        .collection('stockData')
        .doc("Silber")
        .get();

    if (docSnapshot1.exists) {
      Map<String, dynamic>? data = docSnapshot1.data();

      silverInfo.add(MetalInfo(
        time: data?["time"],
        metal: data?["metal"],
        currency: data?["currency"],
        exchange: data?["exchange"],
        ask: data?["ask"],
        bid: data?["bid"],
        zahlSteigung: data?["ch"],
        prozentSteigung: data?["chp"],
        price_gram_24k: data?["price_gram_24k"],
        price_gram_22k: data?["price_gram_22k"],
        price_gram_21k: data?["price_gram_21k"],
        price_gram_20k: data?["price_gram_20k"],
        price_gram_18k: data?["price_gram_18k"],
      ));
    }

    return silverInfo[0].price_gram_24k.toString();
  } else {
    late String stockPrice;
    var docSnapshot = await FirebaseFirestore.instance
        .collection('stockData')
        .doc(data)
        .get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      stockPrice = data?["close"];
    }
    return stockPrice;
  }
}

//Methode holt der Privat Key aus dem Loacl speicher
Future<String> getKey() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getString("privatKey").toString();
}

//Der hochgeladene User Hash wird aus der DB geholt.
Future<String> getHash() async {
  String dbHash = "";
  String uid = FirebaseAuth.instance.currentUser!.uid;
  var collection = FirebaseFirestore.instance.collection('userData');
  var docSnapshot = await collection.doc(uid).get();
  if (docSnapshot.exists) {
    Map<String, dynamic>? data = docSnapshot.data();
    dbHash = data?["userHash"];
  }
  return dbHash;
}
