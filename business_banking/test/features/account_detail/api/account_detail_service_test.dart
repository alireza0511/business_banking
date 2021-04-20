import 'package:business_banking/features/account_detail/api/account_detail_service.dart';
import 'package:business_banking/features/account_detail/api/account_detail_service_response_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('AccountDetailService success', () async {
    final service = AccountDetailService();
    final eitherResponse = await service.request();

    expect(eitherResponse.isRight, isTrue);
    expect(
      eitherResponse.fold((_) {}, (m) => m),
      AccountDetailServiceResponseModel.fromJson({
        'name': 'Employee Checking',
        'lastFour': '6542',
        'accountType': 'Employee Checking',
        'routingNum': 746395735,
        'balance': 3545.54,
        'begBalance': 3674.43,
        'penTrans': -128.89,
        'depHolds': 0.00,
      }),
    );
  });
}
