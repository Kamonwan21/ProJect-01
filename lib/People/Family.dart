import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../Data/data.dart';
import 'Input.dart';

class Person extends StatefulWidget {
  const Person({super.key});

  @override
  State<Person> createState() => _PersonState();
}

class _PersonState extends State<Person> {
  final FlutterTts flutterTts = FlutterTts();

  speak(String text) async {
    await flutterTts.setLanguage("th-TH");
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }

  List<Map<String, dynamic>> _journals = [];
  bool _isLoading = true;

  void _refreshJournals() async {
    final data = await SQLHelper.getItems();
    setState(() {
      _journals = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshJournals();
    print("..number of items ${_journals.length}");

    // Enable Thai input
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    SystemChannels.textInput.invokeMethod('TextInput.show');
  }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Future<void> _addItem() async {
    await SQLHelper.createItem(
        _titleController.text, _descriptionController.text);
    _refreshJournals();
    print("...number of items ${_journals.length}");
  }

  void _deleteItem(int id) async {
    await SQLHelper.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('ลบข้อมูลสำเร็จ'),
    ));
    _refreshJournals();
  }

  // void _showForm(int? id) async {
  //   if (id != null) {
  //     final existingJournal =
  //         _journals.firstWhere((element) => element['id'] == id);
  //     _titleController.text = existingJournal['title'];
  //     _descriptionController.text = existingJournal['descption'];
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "บุคคล",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: _journals.length,
        itemBuilder: (context, index) => Card(
          color: Colors.green[200],
          margin: const EdgeInsets.all(15),
          child: ListTile(
            title: Text(_journals[index]['title']),
            trailing: SizedBox(
              width: 50,
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _deleteItem(_journals[index]['id']),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        backgroundColor: Colors.green,
        onPressed: () {
          speak('เพิ่มข้อมูล');
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => InputScreen(id: null)),
          );
        },
      ),
    );
  }
}
