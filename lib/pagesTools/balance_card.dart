import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stock_x/animation/refresh_animation.dart';
import 'package:stock_x/services/flutterfire_database.dart';
import 'package:stock_x/services/provider/encryption.dart';

/*
Die Datei ist für das Bilden
die card in der E-wallet Page 
die Balanced Card zeigt die ein/auszahlung transaktionen 
von user
*/

class BalanceCard extends StatefulWidget {
  const BalanceCard({Key? key}) : super(key: key);

  @override
  State<BalanceCard> createState() => BalanceCardState();
}

class BalanceCardState extends State<BalanceCard> {
  double heightCard = 300;
  double heightCardNew = 250;
  double height = 250;
  dynamic snapshotData;
  late String dbHash;
  late String privatKey;

  List liste = [
    'Gold',
    "Silber",
    "Deutsche Telekom",
    "Deutsche Post",
    "Deutsche Bank",
    "Allianz"
  ];

//hierfür wird ein stream verwendet um die daten aus der DB zu lesen.
  final Stream<DocumentSnapshot> _usersStream = FirebaseFirestore.instance
      .collection("userData")
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .snapshots();

  @override
  void initState() {
    super.initState();
    getUserData();
  }

//Methode holt der local gespeicherte PrivteKey
  getUserData() async {
    privatKey = await getKey();
  }

//bildet das eigentliche Card.
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() {
        setState(() {
          if (height == heightCard) {
            height = heightCardNew;
          } else {
            height = heightCard;
          }
        });
      }),
      child: Container(
        height: height,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2.0, // soften the shadow
              spreadRadius: 2.0, //extend the shadow
            )
          ],
        ),
        child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .27,
                color: Colors.blue,
                child: StreamBuilder(
                    stream: _usersStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        dynamic data = snapshot.data;
                        snapshotData = snapshot.data;
                        return StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("stockData")
                                .snapshots(), //updatePrice(),
                            builder: (context, snapshot1) {
                              if (snapshot1.hasData) {
                                return Stack(
                                  fit: StackFit.expand,
                                  children: <Widget>[
                                    Center(
                                        child: SingleChildScrollView(
                                            physics:
                                                const BouncingScrollPhysics(),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[],
                                            ))),
                                    const Positioned(
                                      left: -185,
                                      top: -200,
                                      child: CircleAvatar(
                                        radius: 130,
                                        backgroundColor:
                                            Color.fromARGB(165, 255, 255, 255),
                                      ),
                                    ),
                                    const Positioned(
                                      left: -200,
                                      top: -190,
                                      child: CircleAvatar(
                                        radius: 130,
                                        backgroundColor:
                                            Color.fromARGB(255, 105, 182, 245),
                                      ),
                                    ),
                                    const Positioned(
                                      right: -210,
                                      bottom: -170,
                                      child: CircleAvatar(
                                          radius: 130,
                                          backgroundColor: Colors.black),
                                    ),
                                    const Positioned(
                                      right: -200,
                                      bottom: -190,
                                      child: CircleAvatar(
                                          radius: 130,
                                          backgroundColor: Colors.yellow),
                                    )
                                  ],
                                );
                              } else {
                                return Container();
                              }
                            });
                      } else {
                        return Stack(
                          fit: StackFit.expand,
                          children: <Widget>[
                            const Positioned(
                              left: -185,
                              top: -200,
                              child: CircleAvatar(
                                radius: 130,
                                backgroundColor:
                                    Color.fromARGB(165, 255, 255, 255),
                              ),
                            ),
                            const Positioned(
                              left: -200,
                              top: -190,
                              child: CircleAvatar(
                                radius: 130,
                                backgroundColor:
                                    Color.fromARGB(255, 105, 182, 245),
                              ),
                            ),
                            const Positioned(
                              right: -210,
                              bottom: -170,
                              child: CircleAvatar(
                                  radius: 130, backgroundColor: Colors.black),
                            ),
                            const Positioned(
                              right: -200,
                              bottom: -190,
                              child: CircleAvatar(
                                  radius: 130, backgroundColor: Colors.yellow),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: WidgetCircularAnimator(
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.blue),
                                      child: const Icon(
                                        Icons.refresh_rounded,
                                        color: Colors.red,
                                        size: 40,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const SizedBox(
                                  child: Text(
                                    "Datan werden verarbeitet",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ],
                        );
                      }
                    }))),
      ),
    );
  }

//Widget bildet das eigentliche text auf die Card
  Widget cardText(String text, double size, Color color, String text1,
      Color color1, String text2, String text3, Color color2) {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.start,
      children: <Widget>[
        Text(
          textAlign: TextAlign.center,
          "$text ",
          style: TextStyle(fontSize: size, color: color),
        ),
        Text(
          textAlign: TextAlign.center,
          '$text1 ',
          style: TextStyle(fontSize: size, color: color1),
        ),
        Text(
          textAlign: TextAlign.center,
          '$text2 ',
          style: TextStyle(fontSize: size, color: color),
        ),
        Text(
          textAlign: TextAlign.center,
          '$text3 ',
          style: TextStyle(fontSize: size, color: color2),
        )
      ],
    );
  }
}

//Methode berechnet die preis für die angegebne stock/metal menge
String calculate(String menge, String preis) {
  double mengeNeu = double.parse(menge);
  double preisNeu = double.parse(preis);

  double multiplikation = mengeNeu * preisNeu;
  return multiplikation.toStringAsFixed(2).toString();
}
