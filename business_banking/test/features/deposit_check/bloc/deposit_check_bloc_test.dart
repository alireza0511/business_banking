// @dart=2.9
import 'package:business_banking/features/deposit_check/bloc/deposit_check_bloc.dart';
import 'package:business_banking/features/deposit_check/bloc/deposit_check_event.dart';
import 'package:business_banking/features/deposit_check/model/account_info_struct.dart';
import 'package:business_banking/features/deposit_check/model/deposit_check_card_view_model.dart';
import 'package:business_banking/features/deposit_check/model/enums.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'consent_list_usecase_test.dart';
import 'deposit_check_bloc_mock.dart';

void main() {
  DepositCheckBloc bloc;

  MockDepositCheckCardBlockMock mockDepositCheckCardBlockMock;
  MockDepositCheckBlockMock mockDepositCheckBlockMock;
  MockDepositCheckConfirmBlockMock mockDepositCheckConfirmBlockMock;

  DepositCheckCardViewModel depositCheckCardViewModel;

  setUp(() {
    mockDepositCheckCardBlockMock = MockDepositCheckCardBlockMock();
    mockDepositCheckBlockMock = MockDepositCheckBlockMock();
    mockDepositCheckConfirmBlockMock = MockDepositCheckConfirmBlockMock();

    bloc = DepositCheckBloc(
        depositCheckCardUseCase: mockDepositCheckCardBlockMock,
        depositCheckUseCase: mockDepositCheckBlockMock,
        depositCheckConfirmUseCase: mockDepositCheckConfirmBlockMock);
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
    final double tCheckAmount = 2000.00;
    final String tUserEmail = 'alireza@hnb.com';
    final String tImgType = 'front';
    // test('should value receive from pipe be the same as source value', () {
    //   bloc.depositCheckCardViewModelPipe.receive.listen(expectAsync1((model) {
    //     expect(model, depositCheckCardViewModel);
    //   }));
    // }, timeout: Timeout(Duration(seconds: 3)));

    test('should UpdateCheckAmountEvent update the check amount', () async {
      bloc.depositCheckEventPipe.receive.listen((event) {
        if (event is UpdateCheckAmountEvent) {
          verify(mockDepositCheckBlockMock.updateAmount(event.checkAmount))
              .called(1);
        }
      });
      bloc.depositCheckEventPipe.send(UpdateCheckAmountEvent(tCheckAmount));
    });
    test('should UpdateUserEmailEvent update the user email', () {
      bloc.depositCheckEventPipe.receive.listen((event) {
        if (event is UpdateUserEmailEvent) {
          verify(mockDepositCheckBlockMock.updateEmail(event.userEmail))
              .called(1);
        }
      });
      bloc.depositCheckEventPipe.send(UpdateUserEmailEvent(tUserEmail));
    });
    test('should UpdateCheckImgEvent update the check img', () {
      bloc.depositCheckEventPipe.receive.listen((event) {
        if (event is UpdateCheckImgEvent) {
          verify(mockDepositCheckBlockMock.updateImgs(event.imgType)).called(1);
        }
      });
      bloc.depositCheckEventPipe.send(UpdateCheckImgEvent(tImgType));
    });
    test('description', () async {});
  });
}
