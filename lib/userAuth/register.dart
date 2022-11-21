// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

/*
Die Datei ist für das Bilden der Registration-Page
wo der User sich registrieren kann
*/

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController mailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController returnPassController = TextEditingController();
  bool _showPassword = true;
  String password = '';
  String returnPassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
            key: _formKey,
            child: SizedBox(
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
                                // card(
                                //   buildUser(context, mailController),
                                // ),
                                // card(
                                //   buildPassword(
                                //       "Password", password, passController),
                                // ),
                                // card(
                                //   buildPassword("Password wiederholen",
                                //       returnPassword, returnPassController),
                                // ),
                                // const SizedBox(height: 20),
                                // buildButton("Account erstellen", registration,
                                //     250, 20, 15, context),
                              ],
                            ),
                          )))
                ],
              ),
            )));
  }

  ///Bildet den  Passwort-Eingabebereich
  ///in der Register Page
  Widget buildPassword(
      String text, String pass, TextEditingController controller) {
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
            alignment: Alignment.centerLeft,
            child: TextFormField(
              style: const TextStyle(
                color: Colors.black,
              ),
              obscureText: _showPassword,
              controller: controller,
              validator: (value) {
                return null;

                // return Validator.validatePassword(value!, pass, context);
              },
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
                    _showPassword
                        ? Icons.lock_open_outlined
                        : Icons.lock_outline,
                    size: 23,
                    color: Colors.black),
                hintText: text,
                hintStyle: const TextStyle(
                  color: Colors.black,
                ),
              ),
            ))
      ],
    ));
  }
}
