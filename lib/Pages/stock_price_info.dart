// ignore_for_file: prefer_interpolation_to_compose_strings, use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stock_x/models/stock_data_model.dart';
import 'package:stock_x/models/stock_history_model.dart';
import 'package:stock_x/pages/overview.dart';
import 'package:stock_x/pagesTools/charts.dart';
import 'package:stock_x/pagesTools/price_info_comm.dart';
import 'package:stock_x/services/provider/client.dart';


/*
Die Datei ist für das Bilden
der Aktien info page diese kann über die overview erreichet werden.
*/
class StockInfoView extends StatefulWidget {
  final int index;
  final String stockName;
  const StockInfoView(
      {super.key, required this.index, required this.stockName});
  @override
  State<StockInfoView> createState() => StockInfoViewState();
}

class StockInfoViewState extends State<StockInfoView> {
  List<StockInfo> stockData = [];
  List<StockHisInfo> stockHisInfo = [];

  @override
  void initState() {
    super.initState();
    readData();
  }

//Daten über Stream.
  Stream<String> readData() async* {
    String stock = widget.stockName + " History";
    if (stock == "Deutsche Post History") {
      for (int i = 0; i < 3; i++) {
        var docSnapshot2 = await FirebaseFirestore.instance
            .collection(stock)
            .doc("History data: " + i.toString())
            .get();
        if (docSnapshot2.exists) {
          Map<String, dynamic>? data = docSnapshot2.data();
          stockHisInfo.add(StockHisInfo(
            name: widget.stockName,
            datetime: DateTime.parse(data?["dateTime"]),
            high: double.parse(data?["high"]),
            low: double.parse(data?["low"]),
            open: double.parse(data?["open"]),
            close: double.parse(data?["close"]),
          ));
        }
      }
    } else if (stock == "Allianz History") {
      for (int i = 0; i < 12; i++) {
        var docSnapshot2 = await FirebaseFirestore.instance
            .collection(stock)
            .doc("History data: " + i.toString())
            .get();
        if (docSnapshot2.exists) {
          Map<String, dynamic>? data = docSnapshot2.data();
          stockHisInfo.add(StockHisInfo(
            name: widget.stockName,
            datetime: DateTime.parse(data?["dateTime"]),
            high: double.parse(data?["high"]),
            low: double.parse(data?["low"]),
            open: double.parse(data?["open"]),
            close: double.parse(data?["close"]),
          ));
        }
      }
    } else {
      for (int i = 0; i < 12; i++) {
        var docSnapshot2 = await FirebaseFirestore.instance
            .collection(stock)
            .doc("History data: " + i.toString())
            .get();
        if (docSnapshot2.exists) {
          Map<String, dynamic>? data = docSnapshot2.data();
          stockHisInfo.add(StockHisInfo(
            name: widget.stockName,
            datetime: DateTime.parse(data?["dateTime"]),
            high: double.parse(data?["high"]),
            low: double.parse(data?["low"]),
            open: double.parse(data?["open"]),
            close: double.parse(data?["close"]),
          ));
        }
      }
    }
    yield stockHisInfo[0].datetime.toString();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("stockData").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
                appBar: appBar("InfoView"),
                body: RefreshIndicator(
                    onRefresh: () async {
                      await Future.delayed(const Duration(seconds: 2));
                      await fetchData(context);
                      fetchDtHistory();
                      fetchDpHistory();
                      fetchDbHistory();
                      fetchAlHistory();
                    },
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: SizedBox(
                          height: 1100,
                          child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                  width: double.maxFinite,
                                  child: Card(
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(50),
                                        bottomRight: Radius.circular(50),
                                      ),
                                    ),
                                    elevation: 5,
                                    child: GlowingOverscrollIndicator(
                                      axisDirection: AxisDirection.down,
                                      color: Colors.black,
                                      child: Container(
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(50),
                                              bottomRight: Radius.circular(50),
                                            ),
                                            color: Colors.white,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(7),
                                            child: Stack(children: <Widget>[
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Stack(
                                                  children: <Widget>[
                                                    Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 10,
                                                                top: 5),
                                                        child: Stack(
                                                            children: <Widget>[
                                                              Center(
                                                                  child:
                                                                      SingleChildScrollView(
                                                                          physics:
                                                                              const BouncingScrollPhysics(),
                                                                          child:
                                                                              Column(
                                                                            children: <Widget>[
                                                                              Row(
                                                                                children: <Widget>[
                                                                                  const SizedBox(
                                                                                    height: 10,
                                                                                  ),
                                                                                  icon("assets/icons/stock.png", 75, 75),
                                                                                  const SizedBox(
                                                                                    height: 10,
                                                                                  ),
                                                                                  metalNameSymbol("  " + snapshot.data!.docs[widget.index]["name"].toString(), "\n   " + snapshot.data!.docs[widget.index]["symbol"].toString()),
                                                                                  const SizedBox(
                                                                                    width: 10,
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              Column(
                                                                                children: <Widget>[
                                                                                  const SizedBox(
                                                                                    height: 20,
                                                                                  ),
                                                                                  price("Aktien Symbol: " + snapshot.data!.docs[widget.index]["symbol"].toString(), 255, 25, 106, 177),
                                                                                  const SizedBox(
                                                                                    height: 5,
                                                                                  ),
                                                                                  price("Aktien Währung: " + snapshot.data!.docs[widget.index]["currency"].toString(), 255, 25, 106, 177),
                                                                                  price("Hanelzeit: " + snapshot.data!.docs[widget.index]["exchange_timezone"].toString(), 255, 25, 106, 177),
                                                                                  price("Excange: " + snapshot.data!.docs[widget.index]["exchange"].toString(), 255, 25, 106, 177),
                                                                                  const SizedBox(
                                                                                    height: 20,
                                                                                  ),
                                                                                  price("API-Datenzeit: " + snapshot.data!.docs[widget.index]["datetime"].toString(), 255, 25, 106, 177),
                                                                                  price("offnen mit: " + snapshot.data!.docs[widget.index]["open"].toString(), 255, 25, 106, 177),
                                                                                  price("Höhste: " + snapshot.data!.docs[widget.index]["high"].toString(), 255, 25, 106, 177),
                                                                                  price("Geringste: " + snapshot.data!.docs[widget.index]["low"].toString(), 255, 25, 106, 177),
                                                                                  price("geschlossen mit: " + snapshot.data!.docs[widget.index]["close"].toString(), 255, 25, 106, 177),
                                                                                  price("Volumen: " + snapshot.data!.docs[widget.index]["volume"].toString(), 255, 25, 106, 177),
                                                                                  const SizedBox(
                                                                                    height: 20,
                                                                                  ),
                                                                                  StreamBuilder(
                                                                                      stream: readData(),
                                                                                      builder: (context, snapshot1) {
                                                                                        if (snapshot1.hasData) {
                                                                                          return StockChart(liste: stockHisInfo);
                                                                                        } else {
                                                                                          return loading();
                                                                                        }
                                                                                      })
                                                                                ],
                                                                              )
                                                                            ],
                                                                          )))
                                                            ])),
                                                  ],
                                                ),
                                              ),
                                            ]),
                                          )),
                                    ),
                                  ),
                                ),
                              ])),
                    )));
          } else {
            return loading();
          }
        });
  }
}
