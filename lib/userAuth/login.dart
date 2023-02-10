// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_x/pages/e_wallet.dart';
import 'package:stock_x/services/provider/encryption.dart';
import 'package:stock_x/userAuth/flutterfire_auth.dart';
import 'package:stock_x/userAuth/forget_pass.dart';
import 'package:stock_x/userAuth/register.dart';
import 'package:stock_x/userAuth/user_tools.dart';

/*
Die Datei ist für das Bilden der Login Page,
wo der User sich anmelden kann
*/

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController mailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController privatKeyController = TextEditingController();
  bool _showPassword = true;

  Future<void> login() async {
    late String dbHash;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool registerBool = await signIn(mailController.text, passController.text);
    if (registerBool == true) {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      var collection = FirebaseFirestore.instance.collection('userData');
      var docSnapshot = await collection.doc(uid).get();
      if (docSnapshot.exists) {
        Map<String, dynamic>? data = docSnapshot.data();
        dbHash = data?["userHash"];

        if (Encryption.keyHashTest(
                prefs.getString("privatKey").toString(), dbHash) ==
            true) {
          prefs.setBool("login", true);
          Navigator.pop(context);
          setState(() {
            const Wallet();
          });
        } else {
          popupKeyEingabe(context, privatKeyController, dbHash);
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Angegebene Datan sind falsch"),
        backgroundColor: Colors.red,
      ));
    }
    if (prefs.getString("privatKey")!.isEmpty) {
      popupKeyEingabe(context, privatKeyController, dbHash);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            underAppBar("Login", "bitte melden sie sich an"),
            Expanded(
                child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60),
                        )),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          card(buildUser(context, mailController)),
                          card(buildPassword(passController.text)),
                          const SizedBox(height: 20),
                          buildButton("login", login, 250, 20, 15, context),
                          const SizedBox(height: 10),
                          buildButton("Kein Account ?", registerNavigate, 150,
                              10, 10, context),
                          const SizedBox(
                            height: 10,
                          ),
                          buildButton("Passwort vergessen ?",
                              passForgetNavigate, 120, 10, 10, context),
                        ],
                      ),
                    )))
          ],
        ),
      ),
    );
  }

//für das weiterleiten auf Register Page
  void registerNavigate() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const RegisterScreen()));
  }

//für das weiterleiten auf die Passwort vergessen Page
  void passForgetNavigate() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const ForgetPassScreen()));
  }

  ///Bildet den Passwort-Eingabebereich
  ///in der Login Page
  Widget buildPassword(String pass) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        TextFormField(
          style: const TextStyle(color: Colors.black),
          obscureText: _showPassword,
          controller: passController,
          onChanged: (value) => pass = value,
          decoration: InputDecoration(
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() => _showPassword = !_showPassword);
              },
              child: Icon(
                _showPassword ? Icons.visibility : Icons.visibility_off,
                color: Colors.black,
              ),
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.only(top: 14),
            prefixIcon: Icon(
              _showPassword ? Icons.lock_open_outlined : Icons.lock_outline,
              size: 23,
              color: Colors.black,
            ),
            hintText: "Password",
            hintStyle: const TextStyle(
              color: Colors.black,
            ),
          ),
        )
      ],
    );
  }
}

//Widget genereit das User eingabe beriche duch übernahme
//andere Widgets.
Widget card(Widget child) {
  return Padding(
    padding: const EdgeInsets.all(20),
    child: SizedBox(
        width: double.infinity,
        child: Card(
            color: const Color.fromARGB(255, 207, 207, 207),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            clipBehavior: Clip.antiAlias,
            child: GlowingOverscrollIndicator(
                axisDirection: AxisDirection.down,
                color: Colors.black,
                child: SizedBox(child: child)))),
  );
}
