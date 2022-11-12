import 'package:flutter/material.dart';

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
popupRegister(BuildContext context, String userName, String passwort) {
  return showDialog(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          "Erfolgreich Regestriert",
          style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                "Automatisch angemeldet",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 18,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              "Ok",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 18,
                  fontWeight: FontWeight.normal),
            ),
            onPressed: () {},
          ),
        ],
      );
    },
  );
}
