import 'package:flutter/material.dart';

AppBar appBar(String text) {
  return AppBar(
    iconTheme: const IconThemeData(
      color: Colors.black, //change your color here
    ),
    backgroundColor: const Color.fromARGB(255, 207, 207, 207),
    toolbarHeight: 80,
    elevation: 14,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50))),
    centerTitle: true,
    title: Text(
      text,
      style: const TextStyle(color: Colors.black),
    ),
  );
}
