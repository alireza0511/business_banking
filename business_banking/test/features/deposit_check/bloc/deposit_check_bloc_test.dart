// @dart=2.9
import 'package:business_banking/features/deposit_check/bloc/deposit_check_bloc.dart';
import 'package:business_banking/features/deposit_check/model/account_info_struct.dart';
import 'package:business_banking/features/deposit_check/model/deposit_check_card_view_model.dart';
import 'package:business_banking/features/deposit_check/model/enums.dart';
import 'package:test/test.dart';

import 'deposit_check_bloc_mock.dart';

void main() {
  DepositCheckBloc bloc;

  DepositCheckCardViewModel depositCheckCardViewModel;

  setUp(() {
    bloc = DepositCheckBloc();
    // DepositCheckCardViewModel value same as Api Response
    depositCheckCardViewModel = DepositCheckCardViewModel(
        accountInfo: AccountInfoStruct(
            accountNickname: 'Checking Account (...6917)',
            accountNumber: '1234567890126917',
            availableBalance: 481.84,
            depositLimit: 4500.00),
        serviceResponseStatus: ServiceResponseStatus.succeed);
  });

  group('Deposit Check Bloc', () {
    test('should value receive from pipe be the same as source value', () {
      bloc.depositCheckCardViewModelPipe.receive.listen(expectAsync1((model) {
        expect(model, depositCheckCardViewModel);
      }));
    }, timeout: Timeout(Duration(seconds: 3)));
  });
}
