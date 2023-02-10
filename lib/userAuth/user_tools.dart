import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slider_button/slider_button.dart';
import 'package:stock_x/services/provider/encryption.dart';
import 'package:stock_x/userAuth/login.dart';

/*
Die Datei besteht aus allen Widgets, die 
in der Login, Register und User setting Pages 
verwendet wurden 
*/

//Bildet die App Bar
PreferredSizeWidget buildAppBar() {
  return AppBar(
    iconTheme: const IconThemeData(
      color: Colors.black, //change your color here
    ),
    toolbarHeight: 80,
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    centerTitle: true,
  );
}

//Bildet das Text der Unter die Appbar kommt.
Widget underAppBar(String pageName, String pageInfo) {
  return Padding(
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Center(
          child: Text(
            pageName,
            style: const TextStyle(color: Colors.black, fontSize: 40),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Center(
          child: Text(
            pageInfo,
            style: const TextStyle(color: Colors.black, fontSize: 18),
          ),
        )
      ],
    ),
  );
}

/// Bildet die Buttons die in der User Pages verwdnet wurden
Widget buildButton(String text, Function funktion, double width, double padding,
    double borderRadius, BuildContext context) {
  return SizedBox(
      width: width,
      child: ElevatedButton(
          style: ButtonStyle(
              elevation: MaterialStateProperty.all<double>(0.5),
              padding: MaterialStateProperty.all<EdgeInsets>(
                  EdgeInsets.all(padding)),
              backgroundColor: MaterialStateProperty.all<Color>(
                  const Color.fromARGB(255, 207, 207, 207)),
              shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(borderRadius)))),
          onPressed: () {
            funktion();
          },
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              text,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
            ),
          )));
}

/// Bildet die Text die in der User Pages verwendet wurde
Widget buildUser(BuildContext context, TextEditingController userController) {
  return SingleChildScrollView(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
        TextFormField(
          controller: userController,
          style: const TextStyle(color: Colors.black),
          decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(
                Icons.account_box_outlined,
                color: Colors.black,
              ),
              hintText: "E-Mail",
              hintStyle: TextStyle(
                color: Colors.black,
              )),
        )
      ]));
}

/// Bildet die Logo die in der User Pages verwendet wurden
Widget buildImageLogo(
    BuildContext context, String imageLink, double width, double height) {
  return Image.asset(
    imageLink,
    width: width,
    height: height,
    color: Theme.of(context).colorScheme.onBackground,
  );
}

/// Bildet weitere text die in der User Pages verwendet wurden
Widget buildText(BuildContext context, String text, double fontSize) {
  return Text(
    text,
    style: TextStyle(
        color: Theme.of(context).colorScheme.onSurface,
        fontSize: fontSize,
        fontWeight: FontWeight.bold),
  );
}

/// Bildet die PupUp fenster die nach der Registeration erschient
popupKey(BuildContext context) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? key = prefs.getString("privatKey");
  return showDialog(
      context: context,
      //   barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return
            // AlertDialog(
            //   title: Text(
            //     "Erfolgreich Regestriert",
            //     style: TextStyle(
            //         color: Theme.of(context).colorScheme.onSurface,
            //         fontSize: 20,
            //         fontWeight: FontWeight.bold),
            //   ),
            //   content: SingleChildScrollView(
            //     child: ListBody(
            //       children: <Widget>[
            //         Column(
            //           children: [
            //             Text(
            //               "Hier ist ihre Privat Key bitte \nsehr geheim verstecken sie werden es gebrauchen\num auf ihre daten zuzugreifen diese ist nicht zurücksetzbar\n",
            //               style: TextStyle(
            //                   color: Theme.of(context).colorScheme.onSurface,
            //                   fontSize: 18,
            //                   fontWeight: FontWeight.normal),
            //             ),
            //             Row(
            //               children: [
            //                 Text(
            //                   "PrivatKey: $key ",
            //                   style: TextStyle(
            //                       color: Theme.of(context).colorScheme.onSurface,
            //                       fontSize: 18,
            //                       fontWeight: FontWeight.normal),
            //                 ),
            //                 IconButton(
            //                     onPressed: () async {
            //                       await Clipboard.setData(
            //                           ClipboardData(text: key.toString()));
            //                     },
            //                     icon: const Icon(Icons.copy))
            //               ],
            //             )
            //           ],
            //         )
            //       ],
            //     ),
            //   ),
            //   actions: <Widget>[
            //     TextButton(
            //       child: Text(
            //         "Ok",
            //         style: TextStyle(
            //             color: Theme.of(context).colorScheme.onSurface,
            //             fontSize: 18,
            //             fontWeight: FontWeight.normal),
            //       ),
            //       onPressed: () {
            //         Navigator.pop(context);
            //       },
            //     ),
            //   ],
            // );

            Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                elevation: 0.0,
                backgroundColor: Colors.transparent,
                child: Stack(children: <Widget>[
                  Container(
                    height: 380, //Heith
                    padding: const EdgeInsets.only(
                      top: 66 + 16,
                      bottom: 16,
                      left: 16,
                      right: 16,
                    ),
                    margin: const EdgeInsets.only(top: 66),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10.0,
                          offset: Offset(0.0, 10.0),
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          Column(
                            children: [
                              Text(
                                "Erfolgreich Regestriert",
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Hier ist ihre Privat Key bitte \nsehr geheim verstecken sie werden es gebrauchen\num auf ihre daten zuzugreifen diese ist nicht zurücksetzbar\n",
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "PrivatKey: $key ",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                  height: 50,
                                  alignment: Alignment.bottomCenter,
                                  child: SliderButton(
                                    action: () async {
                                      await Clipboard.setData(
                                          ClipboardData(text: key.toString()));
                                      Navigator.of(context).pop();
                                    },
                                    label: const Text(
                                      "PrivatKey  Kopieren    ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    icon: const Center(
                                      child: Icon(Icons.copy),
                                    ),
                                    buttonColor: const Color.fromARGB(
                                        255, 207, 207, 207),
                                    backgroundColor:
                                        const Color.fromARGB(255, 221, 170, 18),
                                    highlightedColor: Colors.black,
                                    baseColor: Colors.white,
                                  )),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 5,
                    right: 5,
                    child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 60,
                        child: SizedBox(
                            child: ClipOval(
                          child: Image.asset(
                            "assets/icons/keyLogo.png",
                          ),
                        ))),
                  ),
                ]));
      });
}

/// Methode bildet Massage die bsp. bei falsche Passwort erschient
void massage(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text),
    backgroundColor: Colors.red,
  ));
}

///Methode ist für das weiterleiten zu anderen Pages
void routeToPage(BuildContext context, var page) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => page),
  );
}

/// Bildet die PupUp fenster die nach der Registeration erschient
popupKeyEingabe(BuildContext context, TextEditingController keyController,
    String hash) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return showDialog(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          "Bitte geben sie Ihre Privat key ein",
          style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                    card(TextFormField(
                      controller: keyController,
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(top: 14),
                          prefixIcon: Icon(
                            Icons.key,
                            color: Colors.black,
                          ),
                          hintText: "Privat Schlüssel",
                          hintStyle: TextStyle(
                            color: Colors.black,
                          )),
                    ))
                  ]))
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              "bestätigen",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 18,
                  fontWeight: FontWeight.normal),
            ),
            onPressed: () {
              if (Encryption.keyHashTest(keyController.text, hash) == true) {
                prefs.setString("privatKey", keyController.text);
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: const Text("Falsche PrivatKey"),
                  backgroundColor: Colors.green.shade300,
                ));
              }
            },
          ),
        ],
      );
    },
  );
}
