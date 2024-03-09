import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class SelectDirectoryPage extends StatefulWidget {
  static const String route = '/directory';

  const SelectDirectoryPage({super.key});

  @override
  State<StatefulWidget> createState() => SelectDirectoryPageState();
}

class SelectDirectoryPageState extends State<SelectDirectoryPage> {
  late TextEditingController _directoryController;

  void initPage() {}

  @override
  void initState() {
    super.initState();
    _directoryController = TextEditingController();
  }

  @override
  void dispose() {
    _directoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select folder file'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 15),
            SizedBox(
              width: 300,
              child: TextField(
                controller: _directoryController,
                obscureText: false,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Directory',
                ),
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton.icon(
              onPressed: () async {
                String? directory =
                    await FilePicker.platform.getDirectoryPath();
                if (directory != null) {
                  _directoryController.text = directory;
                } else {
                  _directoryController.text = '';
                }
              },
              icon: const Icon(Icons.folder),
              label: const Text('Seleziona Directory'),
            ),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () async {},
              icon: const Icon(Icons.lightbulb_outline),
              label: const Text('Avvia calcolo'),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
