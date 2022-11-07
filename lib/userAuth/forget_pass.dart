// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

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
                      children: <Widget>[
                        // card(
                        //   buildUser(context, emailController),
                        // ),
                        // const SizedBox(height: 20),
                        // buildButton("Passwort zurücksetzten", resetPass,
                        //     250, 20, 15, context),
                      ],
                    ),
                  )))
        ],
      ),
    ));
  }
}
