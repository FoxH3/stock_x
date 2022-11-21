import 'package:flutter/material.dart';
import 'package:stock_x/animation/refresh_animation.dart';

//Diese bildet die App bar die in mehreren Pages verwednet wird
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

//Diese Bildet die loading animation die in mehreren Pages verwednet wird
Widget loading() {
  return Center(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      WidgetCircularAnimator(
        child: Container(
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: Colors.grey[200]),
          child: const Icon(
            Icons.refresh_rounded,
            color: Colors.red,
            size: 60,
          ),
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      const Text("Daten werden geladen"),
    ],
  ));
}
