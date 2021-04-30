// @dart=2.9
import 'package:business_banking/features/deposit_check/model/1st_hub_card/deposit_check_card_view_model.dart';
import 'package:business_banking/features/deposit_check/model/2nd_data_entry/deposit_check_view_model.dart';
import 'package:business_banking/features/deposit_check/model/account_info_struct.dart';
import 'package:business_banking/features/deposit_check/model/enums.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DepositCheck View Model', () {
    final tAccountInfo = AccountInfoStruct(
        accountNumber: '1234567890126917',
        availableBalance: 481.84,
        depositLimit: 4500.00,
        accountNickname: 'Checking Account (...6917)');

    final tViewModel = DepositCheckViewModel(
        accountInfo: tAccountInfo,
        depositAmount: 600.0,
        userEmail: 'sample@hnb.com',
        frontCheckImg: 'front',
        backCheckImg: 'back',
        referenceNumber: '#1',
        userEmailStatus: 'userEmailStatus',
        depositAmountStatus: 'depositAmountStatus',
        userInputStatus: UserInputStatus.unknown,
        serviceResponseStatus: ServiceResponseStatus.unknown);

    test('should properties matchs', () {
      expect(tViewModel.accountInfo, tAccountInfo);
      expect(tViewModel.depositAmount, 600.0);
      expect(tViewModel.userEmail, 'sample@hnb.com');
      expect(tViewModel.frontCheckImg, 'front');
      expect(tViewModel.backCheckImg, 'back');
      expect(tViewModel.referenceNumber, '#1');
      expect(tViewModel.userEmailStatus, 'userEmailStatus');
      expect(tViewModel.depositAmountStatus, 'depositAmountStatus');
      expect(tViewModel.userInputStatus, UserInputStatus.unknown);
      expect(tViewModel.serviceResponseStatus, ServiceResponseStatus.unknown);
    });

    test('should props match', () async {
      expect(tViewModel.props, [
        tViewModel.accountInfo,
        tViewModel.depositAmount,
        tViewModel.userEmail,
        tViewModel.frontCheckImg,
        tViewModel.backCheckImg,
        tViewModel.referenceNumber,
      ]);
    });
  });
}
