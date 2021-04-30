// @dart=2.9
import 'package:business_banking/features/deposit_check/bloc/2nd_data_entry/deposit_check_event.dart';
import 'package:business_banking/features/deposit_check/model/enums.dart';
import 'package:test/test.dart';

void main() {
  group('Deposit Check Event', () {
    test('should probs match and stringify be true on UpdateCheckAmountEvent',
        () {
      final event = UpdateCheckAmountEvent(20.0);
      expect(event.props, [20]);
      expect(event.stringify, true);
    });

    test('should probs match and stringify be true on UpdateUserEmailEvent',
        () {
      final event = UpdateUserEmailEvent('sample@hnb.com');
      expect(event.props, ['sample@hnb.com']);
      expect(event.stringify, true);
    });

    test('should probs match and stringify be true on SubmitDepositCheckEvent',
        () {
      final event = SubmitDepositCheckEvent();
      expect(event.props, []);
      expect(event.stringify, true);
    });

    test('should probs match and stringify be true on UpdateCheckImgEvent', () {
      final event = UpdateCheckImgEvent(CheckImageType.front);
      expect(event.props, [CheckImageType.front]);
      expect(event.stringify, true);
    });
  });
}
