// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

/*
Die Datei ist für das Bilden der Login Page,
wo der User sich anmelden kann
*/

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController mailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  bool _showPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
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
                        children: const <Widget>[
                          //card(buildUser(context, mailController)),
                          //  card(buildPassword(passController.text)),
                          SizedBox(height: 20),
                          //  buildButton("login", login, 250, 20, 15, context),
                          SizedBox(height: 10),
                          // buildButton("Kein Account ?", registerNavigate, 150,
                          //   10, 10, context),
                          SizedBox(
                            height: 10,
                          ),
                          // buildButton("Passwort vergessen ?",
                          //     passForgetNavigate, 120, 10, 10, context),
                        ],
                      ),
                    )))
          ],
        ),
      ),
    );
  }

  void registerNavigate() {
    // Navigator.push(context,
    //     MaterialPageRoute(builder: (context) => const RegisterScreen()));
  }

  void passForgetNavigate() {
    // Navigator.push(context,
    //     MaterialPageRoute(builder: (context) => const ForgetPassScreen()));
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

Widget card(Widget cild) {
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
                child: SizedBox(child: cild)))),
  );
}
