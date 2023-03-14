import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_x/Pages/setting.dart';
import 'package:stock_x/pages/overview.dart';
import 'package:stock_x/pages/impressum.dart';
import 'package:stock_x/pages/e_wallet.dart';
import 'package:stock_x/services/provider/flutterfire_darabase.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 238, 238, 238)),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}
// @override
// Widget build(BuildContext context) => MultiProvider(
//       providers: [
//         ChangeNotifierProvider<LocaleProvider>(
//             create: (_) => LocaleProvider(const Locale("en"))),
//         ChangeNotifierProvider<ColorProvider>(create: (_) => ColorProvider()),
//         ChangeNotifierProvider<ThemeProvider>(
//           create: (_) => ThemeProvider()..initialize(),
//         )
//       ],
//       builder: (context, child) {
//         final languageProvider = Provider.of<LocaleProvider>(context);
//         return Consumer<ThemeProvider>(builder: (context, provider, child) {
//           return ScreenUtilInit(
//             builder: ((context, child) => MaterialApp(
//                   theme: Palette.lightTheme,
//                   darkTheme: Palette.darkTheme,
//                   themeMode: provider.themeMode,
//                   locale: languageProvider.locale,
//                   supportedLocales: L10n.all,
//                   localizationsDelegates: const [
//                     //AppLocalizations.delegate,
//                     GlobalMaterialLocalizations.delegate,
//                     GlobalWidgetsLocalizations.delegate
//                   ],
//                   home: const MyHomePage(),
//                 )),
//           );
//         });
//       },
//     );

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  int _selectedScreenIndex = 0;
  late bool screenSwitching = false;
  final List _screens = [
    {"screen": const Overview(), "title": "Overview"},
    {"screen": const Wallet(), "title": "E_Wallet"},
  ];
  String appPass = "";
  bool isAppAktiv = false;

  @override
  initState() {
    super.initState();
    loadHisDataFromDB();
    getPassValues();
  }

//Die von user eingesetzte AppPass wird geholt.
  getPassValues() async {
    appPass = (await getPassowrdState())!;
    setState(() {});
  }

//Überprüft ob die AppPasswort aktiviert ist.
  getAktivState() async {
    isAppAktiv = (await getAktivValues())!;
    setState(() {});
  }

//für die Screen Switch zwischen (Overview und E-Wallet)
  void _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (appPass != "" && isAppAktiv == false) {
      return Scaffold(
        body: Stack(
          children: [
            Center(
                child: SizedBox(
              child: buildApp(),
            )),
            Center(
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.grey.shade200.withOpacity(0.5)),
                    child: Center(
                      child: Column(children: [
                        const SizedBox(
                          height: 300,
                        ),
                        const Text(
                          "App Ensperren um auf die App zuzugreifen",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                            style: ButtonStyle(
                                elevation:
                                    MaterialStateProperty.all<double>(0.5),
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    const EdgeInsets.all(10)),
                                backgroundColor: MaterialStateProperty.all<
                                        Color>(
                                    const Color.fromARGB(255, 207, 207, 207)),
                                shape:
                                    MaterialStateProperty.all<OutlinedBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)))),
                            onPressed: () {
                              screenLock(
                                title: const Text("App-Passwort eingeben",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)),
                                context: context,
                                correctString: appPass,

                                //customizedButtonTap: () async => await localAuth(context),
                                // onOpened: () async => await localAuth(context),
                                onUnlocked: (() {
                                  setState(() {
                                    isAppAktiv = true;
                                  });
                                  Navigator.pop(context);
                                  buildApp();
                                }),
                              );
                            },
                            child: const FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                "App entsperen",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ))
                      ]),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return buildApp();
    }
  }

//Bildet das eigentliche App
  Widget buildApp() {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 207, 207, 207),
          toolbarHeight: 80,
          elevation: 14,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50))),
          centerTitle: true,
          title: Text(
            _screens[_selectedScreenIndex]["title"],
            style: TextStyle(color: Colors.black.withOpacity(1.0)),
          ),
          leading: PopupMenuButton(
            padding: const EdgeInsets.all(10),
            elevation: 10,
            constraints: const BoxConstraints.expand(width: 500, height: 100),
            child: const Icon(
              Icons.dehaze_rounded,
              color: Colors.black,
              size: 30,
            ),
            onSelected: (value) {
              if (value == "Settings") {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Setting()),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Impressumview()),
                );
              }
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                    value: 'Settings',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Icon(
                              Icons.settings,
                              size: 20,
                              color: Colors.black45,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Settings',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        const Divider()
                      ],
                    )),
                PopupMenuItem(
                    value: 'Impressum',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Icon(
                              Icons.account_balance_outlined,
                              size: 20,
                              color: Colors.black45,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Impressum',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        const Divider()
                      ],
                    )),
              ];
            },
          )),
      body: _screens[_selectedScreenIndex]["screen"],
      bottomNavigationBar: SizedBox(
        height: 50,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(topRight: Radius.circular(40)),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: const Color.fromARGB(255, 207, 207, 207),
            iconSize: 20.0,
            selectedIconTheme: const IconThemeData(size: 28.0),
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.black,
            selectedFontSize: 10.0,
            unselectedFontSize: 10,
            currentIndex: _selectedScreenIndex,
            onTap: _selectScreen,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.info_outlined), label: 'übersicht'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.euro_outlined), label: 'E-Wallet'),
            ],
          ),
        ),
      ),
    );
  }

//App Passwort wird geholt als String gespeichert
  Future<String?> getPassowrdState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? appPass = prefs.getString("appPassword");

    return appPass;
  }

//App Passwort status wird geholt als Boolean gespeichert
  Future<bool?> getAktivValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isAppAktiv = prefs.getBool("appAktiv");

    return isAppAktiv;
  }
}
