// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_x/models/metall_data_model.dart';
import 'package:stock_x/models/metall_history_datamodel.dart';
import 'package:stock_x/pages/overview.dart';
import 'package:stock_x/pagesTools/charts.dart';
import 'package:stock_x/pagesTools/price_info_comm.dart';
import 'package:stock_x/services/provider/client.dart';
import 'package:stock_x/services/provider/flutterfire_darabase.dart';

/*
Die Datei ist für das Bilden
der Gold info page diese kann über die overview erreichet werden.
*/
class GoldInfoView extends StatefulWidget {
  const GoldInfoView({Key? key}) : super(key: key);

  @override
  State<GoldInfoView> createState() => InfoViewState();
}

class InfoViewState extends State<GoldInfoView> {
  List<MetalInfo> goldData = [];
  List<GoldHisInfo> historyGold = [];

  @override
  void initState() {
    super.initState();
    loadData();
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
                      await loadData();
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
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(50),
                                              bottomRight: Radius.circular(50),
                                            ),
                                            color: Theme.of(context)
                                                .colorScheme
                                                .surfaceTint,
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
                                                                                  icon("assets/icons/gold.png", 75, 75),
                                                                                  const SizedBox(
                                                                                    height: 10,
                                                                                  ),
                                                                                  metalNameSymbol("  Gold", "\n   ${snapshot.data!.docs[4]["metal"].toString()}"),
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
                                                                                  price("${snapshot.data!.docs[4]["metal"].toString()} Gold"),
                                                                                  const SizedBox(
                                                                                    height: 5,
                                                                                  ),
                                                                                  price("Währung ${snapshot.data!.docs[4]["currency"].toString()}"),
                                                                                  price("exchange ${snapshot.data!.docs[4]["exchange"].toString()}"),
                                                                                  price("Steigerung : ${snapshot.data!.docs[4]["chp"].toString()}% (${snapshot.data!.docs[4]["ch"].toString()})"),
                                                                                  const SizedBox(
                                                                                    height: 20,
                                                                                  ),
                                                                                  price(
                                                                                      // snapshot.data!.docs[4]["price_gram_24k"].toString()
                                                                                      "Preis für 24K : ${snapshot.data!.docs[4]["price_gram_24k"].toString()}"
                                                                                      " €"),
                                                                                  price("Preis für 22K : ${snapshot.data!.docs[4]["price_gram_22k"].toString()}"
                                                                                      " €"),
                                                                                  price("Preis für 21K : ${snapshot.data!.docs[4]["price_gram_21k"].toString()}"
                                                                                      " €"),
                                                                                  price("Preis für 20K : ${snapshot.data!.docs[4]["price_gram_20k"].toString()}"
                                                                                      " €"),
                                                                                  price("Preis für 18K : ${snapshot.data!.docs[4]["price_gram_18k"].toString()}"
                                                                                      " €"),
                                                                                  const SizedBox(
                                                                                    height: 40,
                                                                                  ),
                                                                                  const SizedBox(
                                                                                      height: 20,
                                                                                      child: Text(
                                                                                        "Enwicklung der Goldpreis in den letzten 4 Jahren",
                                                                                        style: TextStyle(fontWeight: FontWeight.bold),
                                                                                      )),
                                                                                  goldChart(historyGold),
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

//die daten werden local ausgelesen und der liste gespeichert
  Future<String> loadData() async {
    loadHisDataFromDB();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    // reading
    var goldHisJson = prefs.getString('goldHistory') ?? '';

    var goldParsedJsonHis = jsonDecode(goldHisJson);

    List<GoldHisInfo> silverHisitems = List<GoldHisInfo>.from(
        goldParsedJsonHis.map((i) => GoldHisInfo.fromJson(i)));

    historyGold = silverHisitems;

    return "";
  }
}
