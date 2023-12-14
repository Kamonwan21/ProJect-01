import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Data/data.dart';
import 'Family.dart';

class InputScreen extends StatefulWidget {
  final int? id;

  const InputScreen({Key? key, this.id}) : super(key: key);

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เพิ่มบุคคล',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(hintText: 'ชื่อบุคคล'),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                if (widget.id == null) {
                  await _addItem();
                }
                if (widget.id != null) {
                  // await _updateItem(id);
                }
                _titleController.text = '';
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Person()));
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green, // Set the background color here
              ),
              child: Text('บันทึก',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }
}
