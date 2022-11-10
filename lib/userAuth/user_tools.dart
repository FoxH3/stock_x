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
