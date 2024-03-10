import 'dart:io';
import 'package:flutter/material.dart';
import 'package:insta_json_analyzer/app/di/injector.dart';
import 'package:insta_json_analyzer/app/utils/const.dart';
import 'package:insta_json_analyzer/app/utils/path.dart';
import 'package:insta_json_analyzer/domain/repository/profile_repository.dart';
import 'package:insta_json_analyzer/presentation/not_follower_page.dart';
import 'package:insta_json_analyzer/presentation/not_following_page.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  static const String route = '/home';

  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final ProfileRepository _profileRepository = injector<ProfileRepository>();
  late bool isPermission;

  Future<bool> _requestPermission(Permission permission) async {
    var result = await Permission.manageExternalStorage.request();
    return result.isGranted;
  }

  String getErrorMessage() {
    String returString =
        'Permessi applicazione mancanti o impossibile trovare file nella cartella $directoryJsonName dentro Download. '
        'L\'applicazione per funzionare necessita della cartella $directoryJsonName dentro la cartella di Download. '
        'Dentro alla cartella $directoryJsonName inserire i file presenti dentro la cartella followers_and_following nei dati scaricati da instagram.';
    return returString;
  }

  Future<void> _initialyzePage() async {
    isPermission = await _requestPermission(Permission.storage);
    if (!isPermission) return;
    String pathFile = await getDownloadDirectoryPath();
    pathFile += "/$directoryJsonName/";
    print(pathFile);
    Directory directory = Directory(pathFile);
    isPermission = await directory.exists();
  }

  @override
  void initState() {
    isPermission = false;
    super.initState();
    _initialyzePage().then((_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 15),
            if (!isPermission) Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: 300,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    _initialyzePage().then((_) {
                      setState(() {});
                    });
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Riprova'),
                ),
              ),
            ),
            if (!isPermission)
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  readOnly: true,
                  maxLines: null,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'INFO',
                    icon: Icon(Icons.warning),
                  ),
                  controller: TextEditingController(
                    text: getErrorMessage(),
                  ),
                ),
              ),
            if (isPermission)
              Column(children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(
                    width: 300,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NotFollowingPage()),
                        );
                      },
                      icon: const Icon(Icons.search),
                      label: const Text('Visualizza non seguiti'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(
                    width: 300,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NotFollowerPage()),
                        );
                      },
                      icon: const Icon(Icons.search),
                      label: const Text('Visualizza che non ti seguono'),
                    ),
                  ),
                ),
              ]),
          ],
        ),
      ),
    );
  }
}
