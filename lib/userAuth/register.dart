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
                              children: <Widget>[
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
}
