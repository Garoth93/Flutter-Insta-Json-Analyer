import 'package:permission_handler/permission_handler.dart';

extension PermissionReq on Object {
  Future<bool> requestStoragePermission(Permission permission) async {
    var result = await Permission.manageExternalStorage.request();
    return result.isGranted;
  }
}
