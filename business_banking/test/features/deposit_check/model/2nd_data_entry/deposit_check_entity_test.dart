// @dart=2.9
import 'package:business_banking/features/deposit_check/model/2nd_data_entry/deposit_check_entity.dart';
import 'package:business_banking/features/deposit_check/model/account_info_struct.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DepositCheck Entity', () {
    final tAccountInfo = AccountInfoStruct(
        accountNumber: '1234567890126917',
        availableBalance: 481.84,
        depositLimit: 4500.00,
        accountNickname: 'Checking Account (...6917)');

    final tEntity = DepositCheckEntity(
        accountInfo: tAccountInfo,
        depositAmount: 600.0,
        userEmail: 'sample@nb.com',
        frontCheckImg: 'front',
        backCheckImg: 'back',
        referenceNumber: '#1',
        errors: []);

    test('should properties match', () {
      expect(tEntity.accountInfo, tAccountInfo);
      expect(tEntity.depositAmount, 600.0);
      expect(tEntity.userEmail, 'sample@nb.com');
      expect(tEntity.frontCheckImg, 'front');
      expect(tEntity.backCheckImg, 'back');
      expect(tEntity.referenceNumber, '#1');
    });

    test('should props match', () async {
      expect(tEntity.props, [
        tEntity.errors,
        tEntity.accountInfo,
        tEntity.depositAmount,
        tEntity.userEmail,
        tEntity.frontCheckImg,
        tEntity.backCheckImg,
        tEntity.referenceNumber
      ]);
    });

    test('should merge func return new Entity with updated data', () async {
      var newEntity = tEntity.merge(depositAmount: 2000.0);
      expect(newEntity.depositAmount, 2000.0);
    });
  });
}
