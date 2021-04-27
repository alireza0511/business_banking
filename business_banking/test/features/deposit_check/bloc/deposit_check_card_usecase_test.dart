// @dart=2.9
import 'package:business_banking/features/deposit_check/bloc/deposit_check_bloc.dart';
import 'package:business_banking/features/deposit_check/bloc/deposit_check_card_usecase.dart';
import 'package:business_banking/features/deposit_check/bloc/deposit_check_usecase.dart';
import 'package:business_banking/features/deposit_check/model/account_info_struct.dart';
import 'package:business_banking/features/deposit_check/model/deposit_check_card_view_model.dart';
import 'package:business_banking/features/deposit_check/model/deposit_check_view_model.dart';
import 'package:business_banking/features/deposit_check/model/enums.dart';
import 'package:test/test.dart';

import 'deposit_check_bloc_mock.dart';

void main() {
  DepositCheckCardUseCase useCase;

  DepositCheckCardViewModel depositCheckCardViewModel;

  setUp(() {
    useCase = DepositCheckCardUseCase((viewModel) {
      depositCheckCardViewModel = viewModel;
    });
  });

  group('Deposit Check Card Usecase', () {
    test('should callback return viewModel the same as source value', () async {
      await useCase.execute();

      expect(
        depositCheckCardViewModel,
        DepositCheckCardViewModel(
            accountInfo: AccountInfoStruct(
                accountNickname: 'Checking Account (...6917)',
                accountNumber: '1234567890126917',
                availableBalance: 481.84,
                depositLimit: 4500.0),
            serviceResponseStatus: ServiceResponseStatus.succeed),
      );
    }, timeout: Timeout(Duration(seconds: 3)));
  });
}
