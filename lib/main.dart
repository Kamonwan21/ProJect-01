import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'People/Family.dart';
import 'models/Page1.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Home());
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FlutterTts flutterTts = FlutterTts();

  speak(String text) async {
    await flutterTts.setSharedInstance(true);
    await flutterTts.setLanguage("th-TH");
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("APHASIA HELP CARE",
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
          children: [
            OutlinedButton(
              onPressed: () {
                speak('คำพูด');
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => Page1(title: "items_talk",title_name: "คำพูด")),
                );
              },
              child: Column(
                children: [
                  Image.asset("images/01.png", width: 200, height: 150),
                  Text(
                    "คำพูด",
                    style: TextStyle(fontSize: 30, color: Colors.black),
                  ),
                ],
              ),
            ),
            OutlinedButton(
              onPressed: () {
                speak('กิน');
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => Page1(title: "items_eat", title_name: 'กิน',)),
                );
              },
              child: Column(
                children: [
                  Image.asset("images/02.png", width: 200, height: 150),
                  Text(
                    "กิน",
                    style: TextStyle(fontSize: 30, color: Colors.black),
                  ),
                ],
              ),
            ),
            OutlinedButton(
              onPressed: () {
                speak('ความรู้สึก');
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => Page1(title: "items_feeling", title_name: 'ความรู้สึก',)),
                );
              },
              child: Column(
                children: [
                  Image.asset("images/03.png", width: 200, height: 150),
                  Text(
                    "ความรู้สึก",
                    style: TextStyle(fontSize: 30, color: Colors.black),
                  ),
                ],
              ),
            ),
            OutlinedButton(
              onPressed: () {
                speak('ของใช้');
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => Page1(title: "items_items", title_name: 'ของใช้',)),
                );
              },
              child: Column(
                children: [
                  Image.asset("images/04.jpg", width: 200, height: 150),
                  Text(
                    "ของใช้",
                    style: TextStyle(fontSize: 30, color: Colors.black),
                  ),
                ],
              ),
            ),
            OutlinedButton(
              onPressed: () {
                speak('งานอดิเรก');
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => Page1(title: "items_hobby", title_name: 'งานอดิเรก',)),
                );
              },
              child: Column(
                children: [
                  Image.asset("images/05.png", width: 200, height: 150),
                  Text(
                    "งานอดิเรก",
                    style: TextStyle(fontSize: 30, color: Colors.black),
                  ),
                ],
              ),
            ),
            OutlinedButton(
              onPressed: () {
                speak('บุคคล');
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Person()),
                );
              },
              child: Column(
                children: [
                  Image.asset("images/06.png", width: 200, height: 150),
                  Text(
                    "บุคคล",
                    style: TextStyle(fontSize: 30, color: Colors.black),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}

