// ignore_for_file: non_constant_identifier_names, prefer_adjacent_string_concatenation
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stock_x/models/metall_data_model.dart';
import 'package:stock_x/models/stock_data_model.dart';
import 'package:stock_x/pages/gold_price_info.dart';
import 'package:stock_x/pages/silver_price_info.dart';
import 'package:stock_x/pages/stock_price_info.dart';
import 'package:stock_x/pagesTools/price_info_comm.dart';
import 'package:stock_x/services/provider/client.dart';

/*
Die Datei ist für das Bilden
der Overview Page in der App
diese geschiet beim start die application
*/

class Overview extends StatefulWidget {
  const Overview({Key? key}) : super(key: key);

  @override
  State<Overview> createState() => OverviewState();
}

class OverviewState extends State<Overview> {
  List<MetalInfo> goldData = [];
  List<MetalInfo> silverData = [];
  List<StockInfo> stockData = [];
  bool GoldpriceDown = false;
  bool SilverpriceDown = false;
  bool dataCatch = false;
  late String date = "";
  List<int> itemInt = [0, 1, 2, 3];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("stockData").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
                body: dataCatch
                    ? const Center(child: CircularProgressIndicator())
                    : RefreshIndicator(
                        onRefresh: () async {
                          setState(() {
                            fetchData(context);
                          });
                          await Future.delayed(const Duration(seconds: 2));
                        },
                        child: SizedBox(
                            height: height,
                            child: SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      SizedBox(
                                        child: Text(
                                            "Aktualisiert am: ${snapshot.data!.docs[4]["time"]}",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      cardInfo(
                                          icon("assets/icons/gold.png", 75, 75),
                                          metalNameSymbol("  Gold",
                                              "\n   ${snapshot.data!.docs[4]["metal"].toString()}"),
                                          metalChange(
                                              snapshot.data!.docs[4]["ch"]
                                                  .toString(),
                                              snapshot.data!.docs[4]["chp"]
                                                  .toString(),
                                              255,
                                              255,
                                              200,
                                              0),
                                          changeIcon(GoldpriceDown),
                                          metalPreis(
                                              snapshot.data!.docs[4]
                                                      ["price_gram_24k"] *
                                                  1000,
                                              snapshot.data!
                                                  .docs[4]["price_gram_24k"]
                                                  .toString(),
                                              255,
                                              255,
                                              200,
                                              0),
                                          const GoldInfoView()),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      cardInfo(
                                          icon("assets/icons/silver.png", 75,
                                              75),
                                          metalNameSymbol("  Silber",
                                              "\n   ${snapshot.data!.docs[6]["metal"].toString()}"),
                                          metalChange(
                                              snapshot.data!.docs[6]["ch"]
                                                  .toString(),
                                              snapshot.data!.docs[6]["chp"]
                                                  .toString(),
                                              255,
                                              158,
                                              158,
                                              158),
                                          changeIcon(SilverpriceDown),
                                          metalPreis(
                                              snapshot.data!.docs[6]
                                                      ["price_gram_24k"] *
                                                  1000,
                                              snapshot.data!
                                                  .docs[6]["price_gram_24k"]
                                                  .toString(),
                                              255,
                                              158,
                                              158,
                                              158),
                                          const SilverInfoView()),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      ListView.separated(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: itemInt.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return cardInfo(
                                              icon("assets/icons/stock.png", 60,
                                                  60),
                                              metalNameSymbol(
                                                  "     ${snapshot.data!.docs[itemInt[index]]["name"].toString()}",
                                                  "\n       ${snapshot.data!.docs[itemInt[index]]["symbol"].toString()}"),
                                              Container(),
                                              Container(),
                                              stockPreis(
                                                "\n" +
                                                    "Heigh: " +
                                                    snapshot
                                                        .data!
                                                        .docs[itemInt[index]]
                                                            ["high"]
                                                        .toString(),
                                                "\n" +
                                                    "Low: " +
                                                    snapshot.data!.docs[
                                                        itemInt[index]]["low"],
                                              ),
                                              StockInfoView(
                                                index: index,
                                                stockName: snapshot
                                                    .data!
                                                    .docs[itemInt[index]]
                                                        ["name"]
                                                    .toString(),
                                              ));
                                        },
                                        separatorBuilder:
                                            (BuildContext context, int index) {
                                          return const Divider();
                                        },
                                      )
                                    ])))));
          } else {
            return loading();
          }
        });
  }

//Diese widget wird verwendet um die cards zu generieren
  Widget cardInfo(
      Widget iconWidget,
      Widget metalNameWidget,
      Widget metalChangeWidget,
      Widget changeIcon,
      Widget priceWidget,
      var goTo) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      height: 180,
      width: double.maxFinite,
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
        ),
        elevation: 5,
        child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
              color: Theme.of(context).colorScheme.surfaceTint,
            ),
            child: InkWell(
              splashColor: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(7),
                child: Stack(children: <Widget>[
                  Align(
                    alignment: Alignment.centerRight,
                    child: Stack(
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.only(left: 10, top: 5),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    iconWidget,
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    metalNameWidget,
                                    const Spacer(),
                                    metalChangeWidget,
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    changeIcon,
                                    const SizedBox(
                                      width: 20,
                                    )
                                  ],
                                ),
                                Row(
                                  children: <Widget>[priceWidget],
                                )
                              ],
                            )),
                      ],
                    ),
                  )
                ]),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => goTo),
                );
              },
            )),
      ),
    );
  }
}

//Folgende widget bildet die icon auf die Card widget
Widget icon(var link, double height, double width) {
  return Padding(
    padding: const EdgeInsets.only(left: 15.0),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Image(
        image: AssetImage(link),
        color: null,
        width: width,
        height: height,
      ),
    ),
  );
}

//Folgende widget bildet die Symbolname auf die Card widget
Widget metalNameSymbol(String name, String bezeichnung) {
  return Align(
    alignment: Alignment.centerLeft,
    child: RichText(
      text: TextSpan(
        text: name.toString(),
        style: const TextStyle(
            fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
        children: <TextSpan>[
          TextSpan(
              text: bezeichnung,
              style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    ),
  );
}

//Folgende widget bildet die preis änderung für gold und silber auf die Card widget
Widget metalChange(var change, var prozent, int a, int r, int g, int b) {
  return Align(
    alignment: Alignment.topRight,
    child: RichText(
      text: TextSpan(
        text: change.toString(),
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(a, r, g, b),
            fontSize: 20),
        children: <TextSpan>[
          TextSpan(
              text: "\n $prozent%",
              style: TextStyle(
                  color: Color.fromARGB(a, r, g, b),
                  fontSize: 15,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    ),
  );
}

//Folgende widget bildet die icon für die preis entwicklung für gold und silber
//auf die Card
Widget changeIcon(bool change) {
  if (change == false) {
    return const Align(
        alignment: Alignment.topRight,
        //hier kommt das symbol für das steigen und fallen
        child: Icon(
          Icons.arrow_drop_down,
          color: Colors.red,
          size: 30,
        ));
  } else {
    return const Align(
        alignment: Alignment.topRight,
        //hier kommt das symbol für das steigen und fallen
        child: Icon(
          Icons.arrow_drop_up,
          color: Colors.green,
          size: 30,
        ));
  }
}

//Folgende widget bildet die preise für gold und silber auf die Card widget
Widget metalPreis(var kPreis, String gPreis, int a, int r, int g, int b) {
  kPreis = kPreis.toStringAsFixed(3);
  return Align(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Row(
        children: <Widget>[
          RichText(
            textAlign: TextAlign.left,
            text: TextSpan(
              text: "\n Kilo preis $kPreis €",
              style: TextStyle(
                color: Color.fromARGB(a, r, g, b),
                fontSize: 20,
              ),
              children: <TextSpan>[
                TextSpan(
                    text: "\n fine Gramm preis $gPreis €",
                    style: TextStyle(
                        color: Color.fromARGB(a, r, g, b),
                        fontStyle: FontStyle.italic,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

//Folgende widget bilder die preis für aktien auf die Card widget
Widget stockPreis(var kPreis, String gPreis) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Row(
        children: <Widget>[
          RichText(
            textAlign: TextAlign.left,
            text: TextSpan(
              text: kPreis,
              style: const TextStyle(
                color: Color.fromARGB(255, 25, 106, 177),
                fontSize: 20,
              ),
              children: <TextSpan>[
                TextSpan(
                    text: gPreis,
                    style: const TextStyle(
                        color: Color.fromARGB(
                            255, 25, 106, 177), //Color.fromARGB(a, r, g, b),
                        fontStyle: FontStyle.italic,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
