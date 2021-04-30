// @dart=2.9
import 'package:business_banking/features/deposit_check/model/1st_hub_card/deposit_check_card_entity.dart';
import 'package:business_banking/features/deposit_check/model/account_info_struct.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DepositCheckCard Entity', () {
    final tAccountInfo = AccountInfoStruct(
        accountNumber: '1234567890126917',
        availableBalance: 481.84,
        depositLimit: 4500.00,
        accountNickname: 'Checking Account (...6917)');

    final tEntity =
        DepositCheckCardEntity(accountInfo: tAccountInfo, errors: []);

    test('should properties match', () {
      expect(tEntity.accountInfo, tAccountInfo);
    });

    test('should props match', () async {
      expect(tEntity.props, [tEntity.errors, tEntity.accountInfo]);
    });

    test('should merge func return new Entity with updated data', () async {
      final newAccountInfo = AccountInfoStruct(
          accountNumber: '1111111111111',
          availableBalance: 1000.0,
          depositLimit: 2000.0,
          accountNickname: 'Account (...1111)');

      var newEntity = tEntity.merge(accountInfo: newAccountInfo);
      expect(newEntity.accountInfo, newAccountInfo);
    });
  });
}
