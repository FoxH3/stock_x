import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*
Die Datei beinhaltet Methoden für die 
Authentifizierung von Usern
*/

//Boolische Mehtode nimmt email & Passwort
//liefert true || false wenn der user exsistert und die daten richtig sind
Future<bool> signIn(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("logMail", email);
    return true;
  } catch (e) {
    return false;
  }
}
