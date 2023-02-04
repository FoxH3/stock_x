/*
Die Datei ist für das Überprüfen der Passwörter,
ob die eingegebenen Passwörter die Eigenschaften besitzen,
die wir geplant haben
*/

class Validator {
  // static String? validatePassword(String pass, String returnPass, context) {
  //   Pattern pattern = r'^(?=.*?[A-Za-z]).{6,200}$';
  //   RegExp regex = RegExp(pattern as String);

  //   ///Überprüft,ob die Passswörter übereinstimmen
  //   /// ob die Fehler leer sind
  //   /// ob die eingegebenen Passwörter die Eigenschaften erfüllen

  //   if (pass != returnPass) {
  //     return '        Keine übereinstimmung';
  //   } else if (pass.isEmpty || returnPass.isEmpty) {
  //     return '        Passwort eingeben';
  //   } else if (!regex.hasMatch(pass) && !regex.hasMatch(returnPass)) {
  //     return '        Keine übereinstimmung';
  //   } else if (returnPass != pass) {
  //     return '        Keine übereinstimmung';
  //   } else {
  //     return null;
  //   }
  // }

  static String? validatePass(String pass, context) {
    Pattern pattern = r'^(?=.*?[A-Za-z]).{6,200}$';
    RegExp regex = RegExp(pattern as String);

    if (pass.isEmpty) {
      return '        Passwort eingeben';
    } else if (!regex.hasMatch(pass)) {
      return '        sechsStellige Passwort eingeben';
    } else {
      return null;
    }
  }
}
