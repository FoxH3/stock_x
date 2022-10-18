import 'package:flutter/material.dart';

/*
Die Datei ist für das Bilden
der Setting Page in der App
*/
class Setting extends StatelessWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: const Color.fromARGB(255, 207, 207, 207),
          toolbarHeight: 80,
          elevation: 14,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50))),
          centerTitle: true,
          title: const Text(
            "Settings",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 10,
                  ),
                  Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: GlowingOverscrollIndicator(
                          axisDirection: AxisDirection.down,
                          color: Colors.black,
                          child: ListTile(
                              leading: const Icon(
                                Icons.info_outline,
                                color: Colors.black,
                              ),
                              title: Text(
                                "Theme Mode",
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              onTap: () {
                                showAboutDialog(
                                  context: context,
                                  applicationIcon: const FlutterLogo(),
                                  applicationLegalese: 'Legalese',
                                  applicationName: 'App Name',
                                  applicationVersion: 'version 1.0.0',
                                );
                              }))),
                  Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: GlowingOverscrollIndicator(
                          axisDirection: AxisDirection.down,
                          color: Colors.black,
                          child: ListTile(
                              leading: const Icon(
                                Icons.account_balance_outlined,
                                color: Colors.black,
                              ),
                              title: Text(
                                "Informationabouttheapplication",
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              onTap: () {}))),
                  const SizedBox(
                    height: 300,
                  ),
                ],
              )),
        ));
  }
}
