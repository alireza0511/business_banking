// @dart=2.9
import 'package:business_banking/features/deposit_check/bloc/1st_hub_card/deposit_check_card_event.dart';
import 'package:business_banking/features/deposit_check/model/account_info_struct.dart';
import 'package:test/test.dart';

void main() {
  group('Deposit Check Card Event', () {
    final tAccountInfo = AccountInfoStruct(
        accountNickname: 'Checking Account (...6917)',
        accountNumber: '1234567890126917',
        availableBalance: 481.84,
        depositLimit: 4500.0);

    test('should probs match and stringify be true on UpdateAccountInfoEvent',
        () {
      final event = UpdateAccountInfoEvent(tAccountInfo);
      expect(event.props, [tAccountInfo]);
      expect(event.stringify, true);
    });
  });
}
