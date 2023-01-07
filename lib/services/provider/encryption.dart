import 'dart:convert';
import 'dart:math';
import 'package:crypt/crypt.dart';
import 'package:encryptor/encryptor.dart';

/*
Die Datei beinhaltet Classe mit mehreren Methoden
die für die Verschlüsselung verwendet werden.
*/

class Encryption {
  static final Random _random = Random.secure();

  //Secret Key wird genereiert
  static String getSecretKey([int length = 9]) {
    var values = List<int>.generate(length, (i) => _random.nextInt(256));
    return base64Url.encode(values);
  }

  //Secret Key wird gehasht
  static String keyHash(String key) {
    final c1 =
        Crypt.sha256(key, salt: 'Gq8RQnsDRFtrjySTbac7AVN5jEfObFVfpl1hxrYRoo2');

    return c1.toString();
  }

  //aus Hash und Privet Key wird verschlüsselt
  static String dataCrypt(String data, String key) {
    String secretKey = key; //Privat key
    return Encryptor.encrypt(secretKey, data).toString();
  }

//überprüft ob das von user angegebene PrivatKey stimmt.
  static bool keyHashTest(String key, String hash) {
    //in if Statment ist die gehschte Pass von User aus der DB
    final c1 =
        Crypt.sha256(key, salt: 'Gq8RQnsDRFtrjySTbac7AVN5jEfObFVfpl1hxrYRoo2');
    if (c1.toString() == hash) {
      return true;
    } else {
      return false;
    }
  }

  //Daten dechiffrieren
  static dataDeCrypt(String key, String data) {
    return Encryptor.decrypt(key, data).toString();
  }
}
