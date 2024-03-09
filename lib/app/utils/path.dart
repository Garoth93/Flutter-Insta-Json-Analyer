import 'dart:io';
import 'package:insta_json_analyzer/app/utils/platform_extension/platform_extension.dart';
import 'package:path_provider/path_provider.dart';

extension DirectoryClass on Object {
  Future<String> getDownloadDirectoryPath() async {
    Directory? directory;
    try {
      if (isIOS()) {
        directory = await getApplicationDocumentsDirectory();
      } else if (isAndroid()) {
        directory = Directory('/storage/emulated/0/Download');
        if (!await directory.exists())
          directory = await getExternalStorageDirectory();
      } else {
        return '';
      }
    } catch (err, stack) {
      print("Cannot get download folder path");
    }
    return directory!.path;
  }
}
