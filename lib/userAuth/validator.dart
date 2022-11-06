class Validator {
  static String? validatePassword(String pass, String returnPass, context) {
    Pattern pattern = r'^(?=.*?[A-Za-z]).{6,200}$';
    RegExp regex = RegExp(pattern as String);

    if (pass != returnPass && returnPass != pass) {
      return '        Keine übereinstimmung';
    } else if (pass.isEmpty || returnPass.isEmpty) {
      return '        Passwort eingeben';
    } else if (!regex.hasMatch(pass) && !regex.hasMatch(returnPass)) {
      return '        Keine übereinstimmung';
    } else {
      return null;
    }
  }

  static String? validatePass(String pass, context) {
    if (pass.isEmpty) {
      return '        Passwort eingeben';
    } else {
      return null;
    }
  }
}
