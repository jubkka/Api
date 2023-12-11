import 'package:api2/translateWindow.dart';
import 'package:flutter/material.dart';
import 'package:api2/currencyConverterWindow.dart';
import 'QrCodeWindow.dart';
import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Api',
      home: Home(),
      routes: {
        '': (BuildContext context) {
          return Home();
        },
        '/translateWindow': (BuildContext context) {
          return translateWindow();
        },
        '/currencyConverterWindow': (BuildContext context) {
          return currencyConverterWindow();
        },
        '/QrCodeWindow': (BuildContext context) {
          return QrCodeWindow();
        },
      },
    );
  }
}