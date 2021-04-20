import 'package:business_banking/features/customer/model/customer_view_model.dart';
import 'package:business_banking/features/customer/model/customer_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('CustomerViewModel initialize', () {
    final viewModel = CustomerViewModel(
        customerEntity: CustomerEntity(
            honorific: "Mr.",
            firstName: "Joe",
            lastName: "A",
            accountType: AccountType.private,
            nickName: ""));
    expect(viewModel.helloString, "Mr. Joe A");

    expect(viewModel.props, [viewModel.helloString]);
  });
  test('CustomerViewModel initialize with error', () {
    try {
      CustomerEntity a = CustomerEntity();
      CustomerViewModel(customerEntity: a);
      expect(false, true);
    } catch (error) {
      expect(error != null, true);
    }
  });
}
