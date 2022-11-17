import 'package:flutter/material.dart';
import 'package:stock_x/Pages/setting.dart';
import 'package:stock_x/config/palette.dart';
import 'package:stock_x/pages/overview.dart';
import 'package:stock_x/pages/impressum.dart';
import 'package:stock_x/pages/e_wallet.dart';
import 'config/l10n/l10n.dart';
import 'package:provider/provider.dart';
import 'services/provider/locale_provider.dart';
import 'services/provider/darkmode_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
//import 'package:flutter_gen/gen_l10n/app_localization.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider<LocaleProvider>(
              create: (_) => LocaleProvider(const Locale("en"))),
          ChangeNotifierProvider<ColorProvider>(create: (_) => ColorProvider()),
          ChangeNotifierProvider<ThemeProvider>(
            create: (_) => ThemeProvider()..initialize(),
          )
        ],
        builder: (context, child) {
          final languageProvider = Provider.of<LocaleProvider>(context);
          return Consumer<ThemeProvider>(builder: (context, provider, child) {
            return ScreenUtilInit(
                builder: ((context, child) => MaterialApp(
                      theme: Palette.lightTheme,
                      darkTheme: Palette.darkTheme,
                      themeMode: provider.themeMode,
                      locale: languageProvider.locale,
                      supportedLocales: L10n.all,
                      localizationsDelegates: const [
                        //AppLocalizations.delegate,
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate
                      ],
                      home: const MyHomePage(),
                    )),
                designSize: const Size(360, 690));
          });
        },
      );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  int _selectedScreenIndex = 0;
  final List _screens = [
    {"screen": const Overview(), "title": "Overview"},
    {"screen": const Wallet(), "title": "E_wallet"},
  ];

  @override
  initState() {
    super.initState();
    //loadData();
    // fetchData();
    // fetchAktienData();
    // fetchMetallHistData();

//Dies wird als zeitstempel für die Daten verwendet
    // DateTime dateToday = new DateTime.now();
    // String date = dateToday.toString().substring(0, 10);
    // print(DateFormat('dd-MM-yyyy').format(DateTime.now()));
  }

  void _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  icon: Icon(Icons.euro_outlined), label: 'E-wallet'),
            ],
          ),
        ),
      ),
    );
  }
}
