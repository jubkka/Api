import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

List<String> listNameCurrency = <String>[''];
List<String> listSymbol = <String>[];

TextEditingController fromAmount = TextEditingController();
TextEditingController toAmount = TextEditingController();

const apiKey = '577c631e15mshfcb7e4eb9c36f21p1c6fd8jsn745500962210';

final getSupportedCurrenciesUrl = Uri.parse(
    'https://currency-converter18.p.rapidapi.com/api/v1/supportedCurrencies');

class currencyConverterWindow extends StatefulWidget {
  currencyConverterWindow({Key? key}) : super(key: key);

  State<currencyConverterWindow> createState() => _currencyConverterWindow();
}

class _currencyConverterWindow extends State<currencyConverterWindow> {
  String dropdownValueOne = listNameCurrency.first;
  String dropdownValueTwo = listNameCurrency.first;

  @override
  void initState() {
    getSupportedCurrencies();
    super.initState();
  }

  Future<void> getSupportedCurrencies() async {
    final headers = {
      'x-rapidapi-host': 'currency-converter18.p.rapidapi.com',
      'x-rapidapi-key': apiKey,
    };

    final response =
        await http.get(getSupportedCurrenciesUrl, headers: headers);

    if (response.statusCode == 200) {
      final supportedCurrency = response.body;

      List text = json.decode(supportedCurrency);

      for (final element in text) {
        listSymbol.add(element['symbol']);
        listNameCurrency.add(element['name']);
      }
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  Future<void> Convert() async {
    if (fromAmount.text.isEmpty) return;
    if (dropdownValueTwo.isEmpty && dropdownValueOne.isEmpty) return;

    final headers = {
      'x-rapidapi-host': 'currency-converter18.p.rapidapi.com',
      'x-rapidapi-key': apiKey,
    };

    var fromSymbol = listSymbol[listNameCurrency.indexOf(dropdownValueOne) - 1];
    var toSymbol = listSymbol[listNameCurrency.indexOf(dropdownValueTwo) - 1];
    double amount = double.parse(fromAmount.text);

    final getConvertUrl = Uri.parse(
        'https://currency-converter18.p.rapidapi.com/api/v1/convert?from=$fromSymbol&to=$toSymbol&amount=$amount');
    final response = await http.get(getConvertUrl, headers: headers);

    if (response.statusCode == 200) {
      final supportedCurrency = response.body;

      Map text = json.decode(supportedCurrency);
      setState(() {
        toAmount.text = text['result']['convertedAmount'].toString();
      });
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
        title: Row(
          children: [
            Icon(
              Icons.currency_pound,
              color: Colors.white,
            ),
            Container(
                padding: EdgeInsets.only(left: 5),
                child: Text(
                  "Конвертер валют",
                  style: TextStyle(color: Colors.white),
                )),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            padding:
                EdgeInsets.only(left: 300, right: 300, bottom: 20, top: 20),
            child: TextField(
              keyboardType: TextInputType.number,
              controller: fromAmount,
              decoration: InputDecoration(
                labelText: 'Введите число',
                labelStyle: TextStyle(fontSize: 15, color: Colors.grey.shade400),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
              ],
            ),
          ),
          Container(
            child: DropdownButton<String>(
              value: dropdownValueOne,
              items: listNameCurrency
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  dropdownValueOne = value!;
                });
              },
            ),
          ),
          Container(
            child: DropdownButton<String>(
              value: dropdownValueTwo,
              items: listNameCurrency
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  dropdownValueTwo = value!;
                });
              },
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 300, right: 300,top: 20),
            child: TextField(
              controller: toAmount,
              readOnly: true,
              decoration: InputDecoration(
              labelStyle: TextStyle(fontSize: 15, color: Colors.grey.shade400),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
            ),
          ),
          Container(
              padding: EdgeInsets.only(top: 20),
              child: ElevatedButton(
                onPressed: Convert,
                child: Text('Конвертировать', style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
              )),
        ],
      ),
    );
  }
}
