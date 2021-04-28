// @dart=2.9
import 'package:business_banking/features/deposit_check/bloc/deposit_check_card_usecase.dart';
import 'package:business_banking/features/deposit_check/model/account_info_struct.dart';
import 'package:business_banking/features/deposit_check/model/deposit_check_card_entity.dart';
import 'package:business_banking/features/deposit_check/model/deposit_check_card_view_model.dart';
import 'package:business_banking/features/deposit_check/model/enums.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:test/test.dart';

import 'consent_list_usecase_test.dart';

void main() {
  DepositCheckCardUseCase useCase;
  MockDepositCheckCardUseCase mockUseCase;

  DepositCheckCardViewModel depositCheckCardViewModel;

  setUp(() {
    useCase = DepositCheckCardUseCase((viewModel) {
      depositCheckCardViewModel = viewModel;
    });

    mockUseCase = MockDepositCheckCardUseCase();
  });

  group('Deposit Check Card Usecase', () {
    final tSucceedAccountInfo = DepositCheckCardViewModel(
        accountInfo: AccountInfoStruct(
            accountNickname: 'Checking Account (...6917)',
            accountNumber: '1234567890126917',
            availableBalance: 481.84,
            depositLimit: 4500.0),
        serviceResponseStatus: ServiceResponseStatus.succeed);
    final tDepositCheckCardEntity = DepositCheckCardEntity(
        accountInfo: AccountInfoStruct(
            accountNickname: 'Checking Account (...6917)',
            accountNumber: '1234567890126917',
            availableBalance: 481.84,
            depositLimit: 4500.0),
        errors: [EntityFailure()]);
    test('should callback return viewModel the same as source value', () async {
      await useCase.execute();

      expect(
        depositCheckCardViewModel,
        tSucceedAccountInfo,
      );
    }, timeout: Timeout(Duration(seconds: 3)));

    test('should callback return viewModel without recreate new scope',
        () async {
      useCase.execute();

      expect(depositCheckCardViewModel, isA<DepositCheckCardViewModel>());
      useCase.execute();
    });
    test(
        'should service response be failed when built view model with entity that has error',
        () async {
      depositCheckCardViewModel =
          useCase.buildViewModel(tDepositCheckCardEntity);

      expect(depositCheckCardViewModel.serviceResponseStatus,
          ServiceResponseStatus.failed);
    });
  });
}
