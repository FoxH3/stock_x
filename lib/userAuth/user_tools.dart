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
