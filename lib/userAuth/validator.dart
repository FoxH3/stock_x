/*
Die Datei ist für das Überprüfen der Passwörter,
ob die eingegebenen Passwörter die Eigenschaften besitzen,
die wir geplant haben
*/

class Validator {
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
