import 'package:flutter/material.dart';
import 'package:slider_button/slider_button.dart';

/// Bildet die PupUp fenster die nach der Registeration erschient
popupRegister(BuildContext context, double height, var klass) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            child: Stack(children: <Widget>[
              Container(
                height: height, //Heith
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
                        "assets/icons/budget.png",
                      ),
                    ))),
              ),
            ]));
      });
}

class TransPupUpview extends StatefulWidget {
  const TransPupUpview({Key? key}) : super(key: key);

  @override
  State<TransPupUpview> createState() => TransPupUpviewState();
}

class TransPupUpviewState extends State<TransPupUpview> {
  String dropdownvalue = 'Gold';
  var items = ['Gold', 'Silber'];
  String neuValue = "";
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
          "Ihre Jetzige Budge beträgt:" "\n gr. Gold" "\n gr. Silber",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16.0,
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
    ));
  }

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
                    dropdownColor: Theme.of(context).colorScheme.surfaceTint,
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
