import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class QrCodeWindow extends StatefulWidget {
  QrCodeWindow({Key? key}) : super(key: key);

  State<QrCodeWindow> createState() => _QrCodeWindow();
}

TextEditingController textController = TextEditingController();
var img;

class _QrCodeWindow extends State<QrCodeWindow> {
  Future<void> generateQrCode() async {
    const apiKey = '577c631e15mshfcb7e4eb9c36f21p1c6fd8jsn745500962210';

    final url = Uri.parse('https://qrcode3.p.rapidapi.com/qrcode/text');

    final headers = {
      'Content-Type': 'application/json',
      'x-rapidapi-host': 'qrcode3.p.rapidapi.com',
      'x-rapidapi-key': apiKey,
    };

    var body = "{\"data\":\"1235434543\",\"style\":{\"module\":{\"color\":\"black\"}},\"size\":{\"width\":200},\"output\":{\"filename\":\"qrcode\",\"format\":\"svg\"}}";

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      setState(() {
        img = response.body;
        print(img);
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
                Icons.qr_code,
                color: Colors.white,
              ),
              Container(
                  padding: EdgeInsets.only(left: 5),
                  child: Text(
                    "Генератор QR кода",
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
                      labelText: 'Введите текст',
                      labelStyle:
                          TextStyle(fontSize: 15, color: Colors.grey.shade400),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)))),
            ),
            Container(
              padding: EdgeInsets.only(left: 250, right: 250),
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

class SvgPicture {
}
