import 'dart:convert';
import 'languages.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class translateWindow extends StatefulWidget {
  translateWindow({Key? key}) : super(key: key);

  State<translateWindow> createState() => _translateWindow();
}

class _translateWindow extends State<translateWindow> {
  TextEditingController textController = TextEditingController();
  String textTranslated = '...';
  String targetLanguage = 'ru';

  Map language = jsonDecode(lang);

  void changeLanguage() {
    SimpleDialog dialog = SimpleDialog(
      title: Text('Выберите язык'),
      children: [],
    );

    List<Widget> list = [];

    for (final element in language['data']['languages']) {
      var option = SimpleDialogOption(
        child: Text(element['language']),
        onPressed: () {
          setState(() {
            targetLanguage = element['language'];
          });
          Navigator.pop(context);
        },
      );
      list.add(option);
    }

    dialog.children?.addAll(list);

    showDialog(
        context: context,
        builder: (context) {
          return dialog;
        });
  }

  Future<void> translate() async {
    const apiKey = '577c631e15mshfcb7e4eb9c36f21p1c6fd8jsn745500962210';

    final url = Uri.parse('https://translate281.p.rapidapi.com/');

    final headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Accept': 'application/gzip',
      'x-rapidapi-host': 'translate281.p.rapidapi.com',
      'x-rapidapi-key': apiKey,
    };

    final body = {
      'text': textController.text,
      'from': 'auto',
      'to': targetLanguage,
    };

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final translatedText = response.body;

      Map text = json.decode(translatedText);

      setState(() {
        textTranslated = text['response'];
      });
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          backgroundColor: Colors.blue,
          title: Row(
            children: [
              Icon(
                Icons.translate,
                color: Colors.white,
              ),
              Container(
                  padding: EdgeInsets.only(left: 5),
                  child: Text(
                    "Переводчик",
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          ),
        ),
        body: Card(
          color: Colors.white,
          margin: const EdgeInsets.all(12),
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: ElevatedButton(
                      onPressed: translate,
                      child: Text("Перевести",
                          style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        elevation: 10,
                        backgroundColor: Colors.blue,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 10,
                          backgroundColor: Colors.blue,
                        ),
                        onPressed: changeLanguage,
                        child: Text(
                          targetLanguage,
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                ],
              ),
              TextField(
                controller: textController,
                minLines: 1,
                maxLines: 5,
                style: const TextStyle(
                  fontSize: 36,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
                decoration: const InputDecoration(
                  hintText: 'Введите текст',
                ),
              ),
              const Divider(
                height: 32,
              ),
              Text(textTranslated,
                  style: const TextStyle(
                      fontSize: 36,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ));
  }
}
