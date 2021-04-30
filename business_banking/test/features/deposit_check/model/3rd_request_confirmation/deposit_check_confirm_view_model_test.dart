// @dart=2.9
import 'package:business_banking/features/deposit_check/model/3rd_request_confirmation/deposit_check_confirm_view_model.dart';
import 'package:business_banking/features/deposit_check/model/account_info_struct.dart';
import 'package:business_banking/features/deposit_check/model/enums.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DepositCheckConfirm View Model', () {
    final tAccountInfo = AccountInfoStruct(
        accountNumber: '1234567890126917',
        availableBalance: 481.84,
        depositLimit: 4500.00,
        accountNickname: 'Checking Account (...6917)');

    final tViewModel = DepositCheckConfirmViewModel(
        accountInfo: tAccountInfo,
        depositAmount: 600.0,
        frontCheckImg: 'front',
        backCheckImg: 'back',
        referenceNumber: '#1',
        serviceResponseStatus: ServiceResponseStatus.unknown);

    test('should properties matchs', () {
      expect(tViewModel.accountInfo, tAccountInfo);
      expect(tViewModel.depositAmount, 600.0);
      expect(tViewModel.frontCheckImg, 'front');
      expect(tViewModel.backCheckImg, 'back');
      expect(tViewModel.referenceNumber, '#1');
      expect(tViewModel.serviceResponseStatus, ServiceResponseStatus.unknown);
    });

    test('should props match', () async {
      expect(tViewModel.props, [
        tViewModel.accountInfo,
        tViewModel.depositAmount,
        tViewModel.frontCheckImg,
        tViewModel.backCheckImg,
        tViewModel.referenceNumber,
      ]);
    });
  });
}
