// @dart=2.9
import 'package:business_banking/dependency/permission_handler_plugin.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:permission_handler/permission_handler.dart';

class MockPermissionHandlerPlugin extends Mock
    implements PermissionHandlerPlugin {
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

void main() {
  PermissionHandlerPlugin permissionHandlerPlugin;
  MockPermissionHandlerPlugin mockPermissionHandlerPlugin;
  setUp(() {
    mockPermissionHandlerPlugin = MockPermissionHandlerPlugin();
    permissionHandlerPlugin = PermissionHandlerPlugin();
  });

  group('Deposit Check Card', () {
    test('description', () async {
      TestWidgetsFlutterBinding.ensureInitialized();
      var sdsd = await permissionHandlerPlugin.isGrantedAccessCamera();
      verify(permissionHandlerPlugin.isGrantedAccessCamera()).called(1);

      expect(sdsd, isA<bool>());
    });
  });
}
