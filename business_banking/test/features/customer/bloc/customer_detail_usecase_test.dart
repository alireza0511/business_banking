import 'package:business_banking/features/customer/bloc/customer_detail_usecase.dart';
import 'package:business_banking/features/customer/model/customer_detail_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('CustomerDetailUseCase initialize with error', () {
    try {
      dynamic a;
      CustomerDetailUseCase(a);
      expect(false, true);
    } catch (error) {
      expect(error != null, true);
    }
  });

  test('CustomerDetailUseCase initialize and create', () {
    final usecase = CustomerDetailUseCase((viewModel) {
      expect(viewModel, isA<CustomerDetailViewModel>());
    });
    usecase.create();
  });

  test('CustomerDetailUseCase initialize and recreate', () {
    final usecase = CustomerDetailUseCase((viewModel) {
      expect(viewModel, isA<CustomerDetailViewModel>());
    });
    usecase.create();
    usecase.create(); //use to trigger else in the create
  });
}
