import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class QrCodeWindow extends StatefulWidget {
  QrCodeWindow({Key? key}) : super(key: key);

  State<QrCodeWindow> createState() => _QrCodeWindow();
}

TextEditingController textController = TextEditingController();

var text;
TextEditingController textCont = TextEditingController();

class _QrCodeWindow extends State<QrCodeWindow> {
  Future<void> generateQrCode() async {
    const apiKey = '577c631e15mshfcb7e4eb9c36f21p1c6fd8jsn745500962210';

    final url = Uri.parse('https://url-shortener-service.p.rapidapi.com/shorten');

    final headers = {
      'content-type': 'application/x-www-form-urlencoded',
      'x-rapidapi-host': 'url-shortener-service.p.rapidapi.com',
      'x-rapidapi-key': apiKey,
    };

    final body = {
      'url' : textController.text,
    };

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      setState(() {
        final link = response.body;
        Map map = json.decode(link);

        print(map['result_url']);
        text = map['result_url'];
        textCont.text = text;
      });
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          backgroundColor: Colors.blue,
          title: Row(
            children: [
              Icon(
                Icons.link,
                color: Colors.white,
              ),
              Container(
                  padding: EdgeInsets.only(left: 5),
                  child: Text(
                    "Сокращение ссылок ",
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          ),
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 250, right: 250, top: 25),
              child: TextField(
                  keyboardType: TextInputType.number,
                  controller: textController,
                  decoration: InputDecoration(
                      labelText: 'Введите ссылку',
                      labelStyle:
                          TextStyle(fontSize: 15, color: Colors.grey.shade400),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)))),
            ),
            Container(
              padding: EdgeInsets.only(left: 250, right: 250),
              child: text == null ? Container() : TextField(
                controller: textCont,
                readOnly: true,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 25),
              child: ElevatedButton(
                onPressed: generateQrCode,
                child: Text(
                  "Сгенерировать",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              ),
            ),
          ],
        ));
  }
}
