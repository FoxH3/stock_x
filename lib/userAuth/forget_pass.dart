// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:stock_x/userAuth/flutterfire_auth.dart';
import 'package:stock_x/userAuth/login.dart';
import 'package:stock_x/userAuth/user_tools.dart';

/*
Die Datei ist für das Bilden die passwort vergessen
Page. diese erschient wenn der user seine Passwort 
zurücksetzten möchte.
*/

class ForgetPassScreen extends StatefulWidget {
  const ForgetPassScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPassScreen> createState() => ForgetPassScreenState();
}

class ForgetPassScreenState extends State<ForgetPassScreen> {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            children: <Widget>[
              underAppBar(
                  "Password Reset", "Sie können ihre Passwort zurücksetzten"),
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
                            card(
                              buildUser(context, emailController),
                            ),
                            const SizedBox(height: 20),
                            buildButton("Passwort zurücksetzten", resetPass,
                                250, 20, 15, context),
                          ],
                        ),
                      )))
            ],
          ),
        ));
  }

//Methode überprüft wird verwednet für die Passwort zurücksetzung.
  Future<void> resetPass() async {
    bool registerBool = await resetPassword(emailController.text);
    if (registerBool == true) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text("Email wurde versendet"),
        backgroundColor: Colors.green.shade300,
      ));
      Future.delayed(const Duration(seconds: 2), () async {
        Navigator.pop(context);
      });
    }
    if (registerBool == false) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("E-mail exsistiert nicht"),
        backgroundColor: Colors.red,
      ));
    }
  }
}
