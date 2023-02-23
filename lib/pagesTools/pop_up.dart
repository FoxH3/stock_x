import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:slider_button/slider_button.dart';
import 'package:stock_x/services/provider/encryption.dart';
import 'package:stock_x/services/provider/flutterfire_darabase.dart';

/*
Die Datei beinhaltet mehrere Widgets/klassen die 
für in der E-Wallet Page verwednet wird.
*/

// Bildet die PupUp für die Transaktionen Buttons in der der e-Wallet
popup(BuildContext context, double height, var klass, String imageLink) {
  return showDialog(
      context: context,
      // user must tap button!
      builder: (BuildContext context) {
        return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            child: Stack(children: <Widget>[
              Container(
                height: height, //Height
                padding: const EdgeInsets.only(
                  top: 66 + 16,
                  bottom: 16,
                  left: 16,
                  right: 16,
                ),
                margin: const EdgeInsets.only(top: 66),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10.0,
                      offset: Offset(0.0, 10.0),
                    ),
                  ],
                ),
                child: klass,
              ),
              Positioned(
                left: 5,
                right: 5,
                child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 66,
                    child: SizedBox(
                        child: ClipOval(
                      child: Image.asset(
                        imageLink,
                      ),
                    ))),
              ),
            ]));
      });
}

// Folgende Class bildet die einzahlen/betrag ändern popup
// in der e-Wallet Page
class TransPupUpview extends StatefulWidget {
  final String pay;
  const TransPupUpview({Key? key, required this.pay}) : super(key: key);

  @override
  State<TransPupUpview> createState() => TransPupUpviewState();
}

class TransPupUpviewState extends State<TransPupUpview> {
  String dropdownvalue = 'Gold';
  String neuValue = "";
  late String privatKey;
  var items = [
    'Gold',
    "Silber",
    "Deutsche Telekom",
    "Deutsche Post",
    "Deutsche Bank",
    "Allianz"
  ];

  @override
  void initState() {
    super.initState();
    getPrivKey();
  }

  getPrivKey() async {
    privatKey = await getKey();
  }

  final Stream<DocumentSnapshot> _usersStream = FirebaseFirestore.instance
      .collection("userData")
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .snapshots();

  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: StreamBuilder(
            stream: _usersStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                dynamic data = snapshot.data;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      "E-Wallet Verwaltung",
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      "Ihre jetziges Budget beträgt:",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      // ignore: prefer_interpolation_to_compose_strings
                      dropdownvalue +
                          ":" +
                          " " +
                          Encryption.dataDeCrypt(
                              privatKey, data[dropdownvalue.toString()]),

                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    _buildMetal(),
                    const SizedBox(
                      height: 5,
                    ),
                    _buildfiled(),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                        height: 50,
                        alignment: Alignment.bottomCenter,
                        child: SliderButton(
                          action: () {
                            if (widget.pay == "Einzahlen") {
                              payIn(dropdownvalue.toString(),
                                  neuValue.toString());
                            } else {
                              setUserData(dropdownvalue.toString(),
                                  neuValue.toString());
                            }

                            Navigator.of(context).pop();
                          },
                          label: const Text(
                            "Transaktion durchführen",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          icon: const Center(
                            child: Icon(Icons.start),
                          ),
                          buttonColor: const Color.fromARGB(255, 207, 207, 207),
                          backgroundColor: Colors.green,
                          highlightedColor: Colors.black,
                          baseColor: Colors.white,
                        )),
                  ],
                );
              } else {
                return const Center(child: Text("Keine Daten"));
              }
            }));
  }

  //bildet die Dropdown Widget in die einzahlen/betrag ändern popup
  Widget _buildMetal() {
    return Card(
        color: const Color.fromARGB(255, 207, 207, 207),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        clipBehavior: Clip.antiAlias,
        child: GlowingOverscrollIndicator(
            axisDirection: AxisDirection.down,
            color: Colors.black,
            child: SizedBox(
                width: 300,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    dropdownColor: const Color.fromARGB(255, 207, 207, 207),
                    style: const TextStyle(color: Colors.black),
                    value: dropdownvalue,
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text("  $items"),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    },
                  ),
                ))));
  }

  //bildet die eingabefeld Widget in die einzahlen/betrag ändern popup
  Widget _buildfiled() {
    return Card(
        color: const Color.fromARGB(255, 207, 207, 207),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        clipBehavior: Clip.antiAlias,
        child: GlowingOverscrollIndicator(
            axisDirection: AxisDirection.down,
            color: Colors.black,
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.number,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  controller: controller,
                  onChanged: (value) => neuValue = value,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Betrag eingeben",
                  ),
                ),
              ],
            )));
  }
}

// Folgende Class bildet die wallet leeren popup
// in der e-Wallet Page
class DeletePupUpview extends StatefulWidget {
  const DeletePupUpview({Key? key}) : super(key: key);

  @override
  State<DeletePupUpview> createState() => DeletePupUpviewState();
}

class DeletePupUpviewState extends State<DeletePupUpview> {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          "E-Wallet verwaltung",
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 16.0),
        const Text(
          "Sie Können ihre E-Wallet leeren",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
            height: 50,
            alignment: Alignment.bottomCenter,
            child: SliderButton(
              action: () {
                removeWallet();
                Navigator.of(context).pop();
              },
              label: const Text(
                "Transaktion durchführen",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              icon: const Center(
                child: Icon(Icons.start),
              ),
              buttonColor: const Color.fromARGB(255, 207, 207, 207),
              backgroundColor: Colors.red,
              highlightedColor: Colors.black,
              baseColor: Colors.white,
            )),
      ],
    ));
  }
}
