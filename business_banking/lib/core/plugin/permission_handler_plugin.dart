import 'package:permission_handler/permission_handler.dart';

abstract class PermissionHandlerPlugin {
  Future<bool> isGrantedAccessCamera();
}

class PermissionHandlerPluginImpl implements PermissionHandlerPlugin {
  @override
  Future<bool> isGrantedAccessCamera() async {
    var status = await Permission.camera.status;
    if (status.isGranted) {
      return true;
    } else {
      var reqStatus = await Permission.camera.request();
      return reqStatus.isGranted;
    }
  }
}
