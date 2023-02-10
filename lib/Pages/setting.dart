import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:stock_x/pagesTools/price_info_comm.dart';

/*
Die Datei ist für das Bilden
der Setting Page in der App
*/

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => SettingState();
}

class SettingState extends State<Setting> {
  bool isSwitchedFT = false;
  bool screenSwitch = false;

  @override
  void initState() {
    super.initState();
    //getSwitchValues();
    getLogin();
  }

//überprüft ob der user schon angemeldet war
  Stream<bool> getLogin() async* {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("login") == true) {
      setState(() {
        screenSwitch = true;
      });
      yield true;
    } else {
      setState(() {
        screenSwitch = false;
      });
      yield false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar("Settings"),
        body: StreamBuilder(
            stream: getLogin(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SafeArea(
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
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                      ),
                                      onTap: () {}))),
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
                                        "Informationabouttheapplication....",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
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
                          screenSwitch
                              ? Card(
                                  color: Colors.red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  child: GlowingOverscrollIndicator(
                                      axisDirection: AxisDirection.down,
                                      color: Colors.black,
                                      child: ListTile(
                                          leading: const Icon(
                                            Icons.logout,
                                            color: Colors.black,
                                          ),
                                          title: Text(
                                            "Abmelden",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2,
                                          ),
                                          onTap: () async {
                                            final SharedPreferences prefs =
                                                await SharedPreferences
                                                    .getInstance();
                                            await prefs.remove("logMail");
                                            await prefs.remove("login");
                                          })))
                              : Container(),
                          const SizedBox(
                            height: 200,
                          ),
                        ],
                      )),
                );
              } else {
                return Container();
              }
            }));
  }

}
