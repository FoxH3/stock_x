import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:stock_x/pagesTools/price_info_comm.dart';
import 'package:stock_x/widgets/darkmode.dart';
import 'package:flutter/src/rendering/box.dart';

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
    getSwitchValues();
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
                              child: const Darkmode()),
                          Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: GlowingOverscrollIndicator(
                                  axisDirection: AxisDirection.down,
                                  color: Colors.black,
                                  child: ListTile(
                                      leading: Icon(
                                        Icons.account_balance_outlined,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                      title: Text(
                                        "Informationen über die Applikation",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
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
                              child: ListTile(
                                  leading: const Icon(
                                    Icons.key,
                                    color: Colors.black,
                                  ),
                                  title: Text(
                                    "App Passwort Aktivieren",
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                  trailing: Container(
                                    margin: const EdgeInsets.only(right: 6.0),
                                    child: Switch(
                                      value: isSwitchedFT,
                                      onChanged: (bool value) {
                                        setState(() {
                                          isSwitchedFT = value;
                                          saveSwitchState(value);
                                        });
                                        if (isSwitchedFT == true) {
                                          screenLockCreate(
                                            title: const Text(
                                                "App-Passwort eingeben",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20)),
                                            confirmTitle: const Text(
                                                "App-Passwort wiederholen",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20)),
                                            context: context,
                                            onConfirmed: (value) {
                                              savePasswordState(value);
                                              Navigator.pop(context);
                                            },
                                            onCancelled: () {
                                              isSwitchedFT = false;
                                              saveSwitchState(false);
                                              setState(() {});
                                              Navigator.pop(context);
                                            },
                                          );
                                        } else {
                                          removePass();
                                        }
                                      },
                                    ),
                                  ))),
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

//holt die switch value für app passwort
  getSwitchValues() async {
    isSwitchedFT = (await getSwitchState())!;
    setState(() {});
  }

//speichert die switch value für app passwort local
  Future<bool> saveSwitchState(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("switchState", value);

    return prefs.setBool("switchState", value);
  }

//holt die switch value für app passwort
  Future<bool?> getSwitchState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isSwitchedFT = prefs.getBool("switchState");

    return isSwitchedFT;
  }

//Speichert die von user angegebene app passwort local
  Future<bool> savePasswordState(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("appPassword", value);

    return prefs.setString("appPassword", value);
  }

//entfernt die von user gespeicherte app passwort
  removePass() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("appPassword");
  }
}
