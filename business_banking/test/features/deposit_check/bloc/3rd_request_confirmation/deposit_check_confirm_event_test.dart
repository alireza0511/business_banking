// @dart=2.9
import 'package:business_banking/features/deposit_check/bloc/3rd_request_confirmation/deposit_check_confirm_event.dart';
import 'package:test/test.dart';

void main() {
  group('Deposit Check Confirm Event', () {
    test(
        'should probs match and stringify be true on ResetDepositCheckViewModelEvent',
        () {
      final event = ResetDepositCheckViewModelEvent();
      expect(event.props, []);
      expect(event.stringify, true);
    });
    test('should probs match and stringify be true on ResetServiceStatusEvent',
        () {
      final event = ResetServiceStatusEvent();
      expect(event.props, []);
      expect(event.stringify, true);
    });
  });
}
