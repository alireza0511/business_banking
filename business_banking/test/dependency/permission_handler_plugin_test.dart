import 'package:business_banking/dependency/permission_handler_plugin.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:permission_handler/permission_handler.dart';

class MockPermissionHandlerPlugin extends Mock
    implements PermissionHandlerPlugin {}

void main() {
  PermissionHandlerPlugin permissionHandlerPlugin;
  MockPermissionHandlerPlugin mockPermissionHandlerPlugin;
  // setUp(() {
  //   mockPermissionHandlerPlugin = MockPermissionHandlerPlugin();
  //   permissionHandlerPlugin = PermissionHandlerPlugin();
  // });

  group('Deposit Check Card', () {
    test('description', () async {
      final tHasGrantedAccessToCamera = Future.value(true);

      // when(permissionHandlerPlugin.isGrantedAccessCamera())
      //     .thenAnswer((_) => tHasGrantedAccessToCamera);
      mockPermissionHandlerPlugin = MockPermissionHandlerPlugin();
      verify(mockPermissionHandlerPlugin.isGrantedAccessCamera());
    });
  });
}
