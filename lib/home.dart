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
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: ElevatedButton(
                onPressed: () { Navigator.pushNamed(context, '/translateWindow'); },
                child: Text("Click 1"),
              )),
          Align(
            alignment: Alignment.centerLeft,
            child: ElevatedButton(
              onPressed: () { Navigator.pushNamed(context, '/currencyConverterWindow'); },
              child: Text("Click 2"),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: ElevatedButton(
              onPressed: () { Navigator.pushNamed(context, '/QrCodeWindow'); },
              child: Text("Click 3"),
            ),
          ),
        ],
      ),
    );
  }
}
