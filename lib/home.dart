import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () { Navigator.pushNamed(context, '/translateWindow'); },
                  child: Icon(Icons.g_translate),
                )),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () { Navigator.pushNamed(context, '/currencyConverterWindow'); },
                child: Icon(Icons.currency_exchange),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () { Navigator.pushNamed(context, '/QrCodeWindow'); },
                child: Icon(Icons.link_outlined),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
