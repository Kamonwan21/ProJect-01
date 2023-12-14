import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Page1 extends StatefulWidget {
  const Page1({super.key, required this.title, required this.title_name});
  final String title;
  final String title_name;
  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  final FlutterTts flutterTts = FlutterTts();

  speak(String text) async {
    await flutterTts.setSharedInstance(true);
    await flutterTts.setLanguage("th-TH");
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }

  List _items = [];
  String page_name = "";
// Fetch content from the json file
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('json_file/icon.json');
    final data = await json.decode(response);

    setState(() {
      _items = data[widget.title];
    });
  }

  @override
  void initState() {
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.title_name}',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: GridView.count(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 0.9,
          shrinkWrap: true,
          children: List.generate(_items.length, (index) {
            return OutlinedButton(
                onPressed: () {
                  if (_items[index]["next_page"] == "") {
                    speak(_items[index]["TH"]);
                  } else {
                    speak(_items[index]["TH"]);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) =>
                              Page1(title: _items[index]["next_page"],title_name: _items[index]["next_title"],)),
                    );
                  }
                },
                child: Column(
                  children: [
                    Image.asset("images/" + _items[index]["IMG"],
                        width: 200, height: 150),
                    Text(
                      _items[index]["TH"],
                      style: TextStyle(fontSize: 23, color: Colors.black),
                    ),
                  ],
                ));
          }),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
