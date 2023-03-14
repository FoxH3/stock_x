import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_x/pagesTools/balance_card.dart';
import 'package:stock_x/pagesTools/pop_up.dart';
import 'package:stock_x/userAuth/login.dart';

/*
Die Datei ist für das Bilden
die e-Wallet Page in der App
*/

class Wallet extends StatefulWidget {
  const Wallet({
    Key? key,
  }) : super(key: key);

  @override
  State<Wallet> createState() => WalletState();
}

class WalletState extends State<Wallet> {
  bool screenSwitch = false;
  String mail = "";

//überprüft ob der user schon angemeldet war
  Stream<bool> getScreen() async* {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("login") == true) {
      setState(() {
        screenSwitch = true;
      });
      yield true;
    } else {
      setState(() {
        screenSwitch = false;
      });
      yield false;
    }
  }

  @override
  void initState() {
    super.initState();
    getMail();
  }

//der mail von angemeldete user wird geholt
  getMail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    mail = prefs.getString("logMail")!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      stream: getScreen(),
      builder: (context, snapshot) {
        if (snapshot.data == true) {
          return eWallet(logout, context, const BalanceCard());
        } else {
          return Stack(
            children: [
              Center(
                  child: SizedBox(
                child: eWallet(
                  null,
                  context,
                  Container(
                    height: 250,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(188, 33, 149, 243),
                          blurRadius: 2.0, // soften the shadow
                          spreadRadius: 2.0, //extend the shadow
                        )
                      ],
                    ),
                  ),
                ),
              )),
              Center(
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.grey.shade200.withOpacity(0.5)),
                      child: Center(
                        child: Column(children: [
                          const SizedBox(
                            height: 250,
                          ),
                          const Text(
                            "Um Auf die Wallet zuzugreifen melden sie sich bitte an",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                              style: ButtonStyle(
                                  elevation:
                                      MaterialStateProperty.all<double>(0.5),
                                  padding: MaterialStateProperty.all<EdgeInsets>(
                                      const EdgeInsets.all(10)),
                                  backgroundColor: MaterialStateProperty.all<
                                          Color>(
                                      const Color.fromARGB(255, 207, 207, 207)),
                                  shape:
                                      MaterialStateProperty.all<OutlinedBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)))),
                              onPressed: () {
                                toLogin(context);
                              },
                              child: const FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ))
                        ]),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }
      },
    ));
  }

//bildet die icons in der wallet bereich diese sind die einzahlen,
// betrag öndern und Wallet leeren
  Widget icon(context, IconData icon, String text) {
    return Column(
      children: <Widget>[
        InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          onTap: () {
            if (text == "Einzahlen") {
              popup(context, 420, const TransPupUpview(pay: "Einzahlen"),
                  "assets/icons/budget.png");
            }
            if (text == "Betrag ändern") {
              popup(context, 420, const TransPupUpview(pay: "Betrag ändern"),
                  "assets/icons/budget.png");
            }
            if (text == "Wallet leeren") {
              popup(context, 250, const DeletePupUpview(),
                  "assets/icons/budget.png");
            }
          },
          child: Container(
            height: 80,
            width: 80,
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Color(0xfff3f3f3),
                      offset: Offset(5, 5),
                      blurRadius: 10)
                ]),
            child: Icon(icon),
          ),
        ),
        Text(
          text,
        ),
      ],
    );
  }

//die Methode dient für das abmelden er user
  void logout(context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    mail = "";
    await prefs.remove("logMail");
    await prefs.remove("login");
    setState(() {});
  }

//Methode wird für das navigieren in die login page verwendet
  toLogin(context) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

//diese bildet das eigenltiche e wallet
  Widget eWallet(var method, context, Widget widget) {
    return SafeArea(
        child: SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 25),
              Align(
                  alignment: Alignment.topLeft,
                  child: Wrap(children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          "Hello, $mail",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const Expanded(
                          child: SizedBox(),
                        ),
                      ],
                    ),
                  ])),
              Row(
                children: [
                  const Text("Ausloggen"),
                  InkWell(
                    child: Icon(
                      Icons.logout,
                      size: 30,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    onTap: () {
                      method(context);
                    },
                  )
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              const Text("My Wallet",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 20,
              ),
              widget,
              const SizedBox(
                height: 20,
              ),
              const Text("Operationen",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  icon(context, Icons.payments_outlined, "Einzahlen"),
                  icon(context, Icons.price_change_outlined, "Betrag ändern"),
                  icon(context, Icons.delete_forever_outlined, "Wallet leeren"),
                ],
              ),
            ],
          )),
    ));
  }
}
