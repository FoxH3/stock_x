import 'package:flutter/material.dart';
import 'package:stock_x/pop_up.dart';

/*
Die Datei ist für das Bilden
der Setting Page in der App
*/

class Wallet extends StatelessWidget {
  const Wallet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 35),
              Row(
                children: <Widget>[
                  const SizedBox(width: 5),
                  const Text(
                    "Hello User",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  InkWell(
                    child: Icon(
                      Icons.logout,
                      size: 30,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    onTap: () {},
                  )
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              const Text("My wallet",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 20,
              ),
              const BalanceCard(),
              const SizedBox(
                height: 20,
              ),
              const Text("Operationen",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _icon(context, Icons.payments_outlined, "Einzahlen"),
                  _icon(context, Icons.price_change_outlined, "Betrag ändern"),
                  _icon(
                      context, Icons.delete_forever_outlined, "Wallet leeren"),
                ],
              ),
            ],
          )),
    )));
  }

  Widget _icon(context, IconData icon, String text) {
    return Column(
      children: <Widget>[
        InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          onTap: () {
            if (text == "Einzahlen") {
              popupRegister(context, 420, const TransPupUpview());
            }
            if (text == "Betrag ändern") {
              popupRegister(context, 420, const TransPupUpview());
            }
            if (text == "Wallet leeren") {
              popupRegister(context, 250, const DeletePupUpview());
            }
          },
          child: Container(
            height: 80,
            width: 80,
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Color(0xfff3f3f3),
                      offset: Offset(5, 5),
                      blurRadius: 10)
                ]),
            child: Icon(icon),
          ),
        ),
        Text(
          text,
        ),
      ],
    );
  }
}

class BalanceCard extends StatelessWidget {
  const BalanceCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 2.0, // soften the shadow
            spreadRadius: 2.0, //extend the shadow
            // offset: Offset(
            //   1.0, // Move to right 5  horizontally
            //   1.0, // Move to bottom 5 Vertically
            // ),
          )
        ],
      ),
      child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
          //BorderRadius.all(Radius.circular(40)),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .27,
            color: Colors.blue,
            // LightColor.navyBlue1,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Ihre Guthaben',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        //  LightColor.lightNavyBlue
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Text(
                          '6,354 gr. ',
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          ' Gold',
                          style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.w500,
                              color: Colors.yellow
                              // LightColor.yellow.withAlpha(200)
                              ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Text(
                          'Entspricht: ',
                          style: TextStyle(
                            fontSize: 15,
                            // LightColor.yellow.withAlpha(200)
                          ),
                          // style: GoogleFonts.mulish(
                          //     textStyle: Theme.of(context).textTheme.headline4,
                          //     fontSize: 15,
                          //     fontWeight: FontWeight.w600,
                          //     color: LightColor.lightNavyBlue),
                        ),
                        Text(
                          '15,000 €',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                const Positioned(
                  left: -170,
                  top: -170,
                  child: CircleAvatar(
                    radius: 130,
                    backgroundColor: Colors.blue,
                    //LightColor.lightBlue2,
                  ),
                ),
                const Positioned(
                  left: -160,
                  top: -190,
                  child: CircleAvatar(
                    radius: 130,
                    backgroundColor: Color.fromARGB(255, 105, 182, 245),
                    //LightColor.lightBlue1,
                  ),
                ),
                const Positioned(
                  right: -170,
                  bottom: -170,
                  child: CircleAvatar(radius: 130, backgroundColor: Colors.black
                      // LightColor.yellow2,
                      ),
                ),
                const Positioned(
                  right: -160,
                  bottom: -190,
                  child:
                      CircleAvatar(radius: 130, backgroundColor: Colors.yellow
                          //LightColor.yellow,
                          ),
                )
              ],
            ),
          )),
    );
  }

  Widget demoWallet() {
    return SafeArea(
        child: SingleChildScrollView(
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 35),
              Row(
                children: <Widget>[
                  const SizedBox(width: 5),
                  const Text(
                    "Hello User",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  InkWell(
                    child: Icon(
                      Icons.logout,
                      size: 30,
                      //  color: Theme.of(context).iconTheme.color,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              const Text("My wallet",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 250,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(188, 33, 149, 243),
                      blurRadius: 2.0, // soften the shadow
                      spreadRadius: 2.0, //extend the shadow
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text("Operationen",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  // _icon(context, Icons.payments_outlined, "Einzahlen"),
                  // _icon(context, Icons.price_change_outlined, "Betrag ändern"),
                  // _icon(
                  //     context, Icons.delete_forever_outlined, "Wallet leeren"),
                ],
              ),
            ],
          )),
    ));
  }
}
