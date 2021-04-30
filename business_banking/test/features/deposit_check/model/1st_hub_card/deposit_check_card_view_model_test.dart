// @dart=2.9
import 'package:business_banking/features/deposit_check/model/1st_hub_card/deposit_check_card_view_model.dart';
import 'package:business_banking/features/deposit_check/model/account_info_struct.dart';
import 'package:business_banking/features/deposit_check/model/enums.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DepositCheckCard View Model', () {
    final tAccountInfo = AccountInfoStruct(
        accountNumber: '1234567890126917',
        availableBalance: 481.84,
        depositLimit: 4500.00,
        accountNickname: 'Checking Account (...6917)');

    final tViewModel = DepositCheckCardViewModel(
        accountInfo: tAccountInfo,
        serviceResponseStatus: ServiceResponseStatus.unknown);

    test('should properties matchs', () {
      expect(tViewModel.accountInfo, tAccountInfo);
      expect(tViewModel.serviceResponseStatus, ServiceResponseStatus.unknown);
    });

    test('should props match', () async {
      expect(tViewModel.props,
          [tViewModel.accountInfo, tViewModel.serviceResponseStatus]);
    });
  });
}
