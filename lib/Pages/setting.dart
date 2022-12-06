import 'package:flutter/material.dart';
import 'package:stock_x/widgets/darkmode.dart';

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
                      child: const GlowingOverscrollIndicator(
                          axisDirection: AxisDirection.down,
                          color: Colors.grey,
                          child: Darkmode())),
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
                                "Informationen über die Applikation",
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              onTap: () {
                                showAboutDialog(
                                  context: context,
                                  applicationIcon: const FlutterLogo(),
                                  applicationLegalese: 'Legalese',
                                  applicationName: 'Stock X',
                                  applicationVersion: 'version 1.0.0',
                                );
                              }))),
                  const SizedBox(
                    height: 300,
                  ),
                ],
              )),
        ));
  }
}
