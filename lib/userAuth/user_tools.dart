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
