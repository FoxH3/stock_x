import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*
Die Datei bethoden die für Transatkionen 
auf die Datenbank durchführen.
*/

//Methode holt der Privat Key aus dem Loacl speicher
Future<String> getKey() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getString("privatKey").toString();
}

//Der hochgeladene User Hash wird aus der DB geholt.
Future<String> getHash() async {
  String dbHash = "";
  String uid = FirebaseAuth.instance.currentUser!.uid;
  var collection = FirebaseFirestore.instance.collection('userData');
  var docSnapshot = await collection.doc(uid).get();
  if (docSnapshot.exists) {
    Map<String, dynamic>? data = docSnapshot.data();
    dbHash = data?["userHash"];
  }
  return dbHash;
}
