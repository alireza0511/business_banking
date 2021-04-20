import 'package:business_banking/features/account_detail/api/account_detail_service_response_model.dart';
import 'package:business_banking/features/account_detail/bloc/account_detail_service_adapter.dart';
import 'package:business_banking/features/account_detail/model/account_detail_entity.dart';
import 'package:test/test.dart';

void main() {
  test('Entity is created by service adapter', () {
    final entity = AccountDetailServiceAdapter().createEntity(
      AccountDetailEntity(),
      AccountDetailServiceResponseModel.fromJson({
        "name": "Employee Checking",
        "lastFour": "6542",
        "accountType": "Employee Checking",
        "routingNum": 746395735,
        "balance": 3545.54,
        "begBalance": 3674.43,
        "penTrans": -128.89,
        "depHolds": 0.00
      }),
    );

    expect(
        entity,
        AccountDetailEntity(
          name: 'Employee Checking',
          lastFour: '6542',
          accountType: 'Employee Checking',
          routingNumber: 746395735,
          balance: 3545.54,
          beginningBalance: 3674.43,
          pendingTransactions: -128.89,
          depositHolds: 0.00,
        ));
  });
  test('init entity created is nulls fails', () {
    try {
      AccountDetailServiceAdapter().createEntity(
        null,
        AccountDetailServiceResponseModel.fromJson({
          "name": "Employee Checking",
          "lastFour": "6542",
          "accountType": "Employee Checking",
          "routingNum": 746395735,
          "balance": 3545.54,
          "begBalance": 3674.43,
          "penTrans": -128.89,
          "depHolds": 0.00
        }),
      );
    } catch (e) {
      expect(e, true);
    }
  });
  // test('init response model created is null fails', () {
  //   try {
  //     AccountDetailServiceAdapter().createEntity(AccountDetailEntity(), null);
  //   } catch (e) {
  //     expect(e != null, true);
  //   }
  // });
}
