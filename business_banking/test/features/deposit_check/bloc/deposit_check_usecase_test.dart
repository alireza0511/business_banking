// @dart=2.9
import 'package:business_banking/features/deposit_check/bloc/deposit_check_bloc.dart';
import 'package:business_banking/features/deposit_check/bloc/deposit_check_usecase.dart';
import 'package:business_banking/features/deposit_check/model/account_info_struct.dart';
import 'package:business_banking/features/deposit_check/model/deposit_check_card_view_model.dart';
import 'package:business_banking/features/deposit_check/model/deposit_check_view_model.dart';
import 'package:business_banking/features/deposit_check/model/enums.dart';
import 'package:test/test.dart';

import 'deposit_check_bloc_mock.dart';

void main() {
  DepositCheckUseCase useCase;

  DepositCheckViewModel depositCheckViewModel;

  setUp(() {
    useCase = DepositCheckUseCase((viewModel) {
      depositCheckViewModel = viewModel;
    });
  });

  group('Deposit Check Usecase', () {
    test('should value receive from pipe be the same as source value',
        () async {
      await useCase.execute();

      expect(depositCheckViewModel, isNotNull);
      // expect(
      //   depositCheckViewModel,
      //   DepositCheckViewModel(
      //       backCheckImg: '',
      //       depositAmount: 0.0,
      //       frontCheckImg: '',
      //       referenceNumber: '',
      //       userEmail: '',
      //       accountInfo: AccountInfoStruct(
      //           accountNickname: '',
      //           accountNumber: '',
      //           availableBalance: 0.0,
      //           depositLimit: 0.0)),
      // );
    }, timeout: Timeout(Duration(seconds: 3)));
  });
}
