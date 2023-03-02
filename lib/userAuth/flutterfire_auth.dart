import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_x/services/provider/client.dart';
import 'package:stock_x/services/provider/encryption.dart';

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

//Boolische Mehtode nimmt email & Passwort
//liefert true || false
Future<bool> register(String email, String password) async {
  try {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String privatKey = Encryption.getSecretKey();

    await prefs.setString("privatKey", privatKey);
    String privatKeyHash = "";
    privatKeyHash = Encryption.keyHash(privatKey);

    List<String> itemList = [
      "A.data",
      "B.data",
      "C.data",
      "D.data",
      "E.data",
      "E.data",
      "F.data",
      "G.data",
      "H.data",
      "I.data",
      "K.data",
      "L.data",
      "M.data",
      "N.data"
    ];
    List<String> dataListe;

    dataListe = await getList("Data for User", itemList);

    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

//Doc für Regestreite User erstellen.
    String uid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection('userData').doc(uid).set({
      dataListe[0]: email,
      dataListe[1]:
          Encryption.dataCrypt("0", prefs.getString("privatKey").toString()),
      dataListe[2]:
          Encryption.dataCrypt("0", prefs.getString("privatKey").toString()),
      dataListe[3]:
          Encryption.dataCrypt("0", prefs.getString("privatKey").toString()),
      dataListe[4]:
          Encryption.dataCrypt("0", prefs.getString("privatKey").toString()),
      dataListe[5]:
          Encryption.dataCrypt("0", prefs.getString("privatKey").toString()),
      dataListe[6]:
          Encryption.dataCrypt("0", prefs.getString("privatKey").toString()),
      dataListe[7]:
          Encryption.dataCrypt("0", prefs.getString("privatKey").toString()),
      dataListe[8]:
          Encryption.dataCrypt("0", prefs.getString("privatKey").toString()),
      dataListe[9]:
          Encryption.dataCrypt("0", prefs.getString("privatKey").toString()),
      dataListe[10]:
          Encryption.dataCrypt("0", prefs.getString("privatKey").toString()),
      dataListe[11]:
          Encryption.dataCrypt("0", prefs.getString("privatKey").toString()),
      dataListe[12]:
          Encryption.dataCrypt("0", prefs.getString("privatKey").toString()),
      dataListe[13]: privatKeyHash
    });

    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
    return false;
  } catch (e) {
    return false;
  }
}

Future<bool> resetPassword(String mail) async {
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: mail.trim());
    return true;
  } on FirebaseException {
    return false;
  }
}
