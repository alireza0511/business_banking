// @dart=2.9
import 'package:business_banking/features/deposit_check/bloc/1st_hub_card/deposit_check_card_event.dart';
import 'package:business_banking/features/deposit_check/bloc/2nd_data_entry/deposit_check_event.dart';
import 'package:business_banking/features/deposit_check/bloc/3rd_request_confirmation/deposit_check_confirm_event.dart';
import 'package:business_banking/features/deposit_check/bloc/deposit_check_bloc.dart';
import 'package:business_banking/features/deposit_check/model/1st_hub_card/deposit_check_card_view_model.dart';
import 'package:business_banking/features/deposit_check/model/2nd_data_entry/deposit_check_view_model.dart';
import 'package:business_banking/features/deposit_check/model/account_info_struct.dart';
import 'package:business_banking/features/deposit_check/model/enums.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'consent_list_usecase_test.dart';

void main() {
  DepositCheckBloc bloc;

  MockDepositCheckCardUseCase mockDepositCheckCardUseCase;
  MockDepositCheckUseCase mockDepositCheckUseCase;
  MockDepositCheckConfirmUseCase mockDepositCheckConfirmUseCase;

  //DepositCheckCardViewModel depositCheckCardViewModel;

  setUp(() {
    mockDepositCheckCardUseCase = MockDepositCheckCardUseCase();
    mockDepositCheckUseCase = MockDepositCheckUseCase();
    mockDepositCheckConfirmUseCase = MockDepositCheckConfirmUseCase();

    bloc = DepositCheckBloc(
        depositCheckCardUseCase: mockDepositCheckCardUseCase,
        depositCheckUseCase: mockDepositCheckUseCase,
        depositCheckConfirmUseCase: mockDepositCheckConfirmUseCase);
  });

  tearDown(() {
    bloc.dispose();
    expect(bloc.depositCheckCardViewModelPipe.receive, emitsDone);
    expect(bloc.depositCheckViewModelPipe.receive, emitsDone);
    expect(bloc.depositCheckConfirmViewModelPipe.receive, emitsDone);
    expect(bloc.depositCheckEventPipe.receive, emitsDone);
  });
  group('Deposit Check Bloc', () {
    final double tCheckAmount = 2000.00;
    final String tUserEmail = 'alireza@hnb.com';
    final CheckImageType tImgType = CheckImageType.front;
    final AccountInfoStruct tAccountInfo = AccountInfoStruct(
        accountNickname: 'Checking Account (...6917)',
        accountNumber: '1234567890126917',
        availableBalance: 481.84,
        depositLimit: 4500.00);

    test(
        'should depositCheckCardViewModelPipe gets view model with real usecase',
        () {
      bloc.depositCheckCardViewModelPipe
          .send(DepositCheckCardViewModel(accountInfo: tAccountInfo));
      bloc.depositCheckCardViewModelPipe.receive.listen((model) {
        verify(mockDepositCheckCardUseCase.execute()).called(1);
      });
    });
    test('should depositCheckViewModelPipe gets view model with real usecase',
        () {
      bloc.depositCheckViewModelPipe
          .send(DepositCheckViewModel(accountInfo: tAccountInfo));
      bloc.depositCheckViewModelPipe.receive.listen((model) {
        verify(mockDepositCheckUseCase.execute()).called(1);
      });
    });
    // test('should depositCheckConfirmViewModelPipe gets view model with usecase',
    //     () {
    //   bloc.depositCheckConfirmViewModelPipe.receive.listen((model) {
    //     expect(model, isA<DepositCheckConfirmViewModel>());
    //   });
    // });

    test('should depositCheckEventPipeHandler calls correct method', () {
      bloc.depositCheckEventPipe.receive.listen((event) {
        if (event is UpdateCheckAmountEvent) {
          verify(mockDepositCheckUseCase.updateAmount(tCheckAmount)).called(1);
        }
        if (event is UpdateUserEmailEvent) {
          verify(mockDepositCheckUseCase.updateEmail(tUserEmail)).called(1);
        }
        if (event is UpdateCheckImgEvent) {
          verify(mockDepositCheckUseCase.updateImgs(tImgType)).called((1));
        }
        if (event is UpdateAccountInfoEvent) {
          verify(mockDepositCheckUseCase.updateAccountInfo(tAccountInfo))
              .called((1));
        }
        if (event is SubmitDepositCheckEvent) {
          verify(mockDepositCheckUseCase.submitDepositCheck()).called((1));
        }
        if (event is ResetDepositCheckViewModelEvent) {
          //verify(mockDepositCheckUseCase.resetViewModel()).called(1);
        }
        // if (event is ResetServiceStatusEvent) {
        //   verify(mockDepositCheckUseCase.resetServiceStatus()).called((1));
        // }
      });

      bloc.depositCheckEventPipeHandler(UpdateCheckAmountEvent(tCheckAmount));
      bloc.depositCheckEventPipeHandler(UpdateUserEmailEvent(tUserEmail));
      bloc.depositCheckEventPipeHandler(UpdateCheckImgEvent(tImgType));
      bloc.depositCheckEventPipeHandler(SubmitDepositCheckEvent());

      bloc.depositCheckCardEventPipeHandler(
          UpdateAccountInfoEvent(tAccountInfo));
      bloc.depositCheckConfirmEventPipeHandler(ResetServiceStatusEvent());
    });
    test('should update the check amount by UpdateCheckAmountEvent func',
        () async {
      bloc.depositCheckViewModelPipe.receive.listen((event) {
        expect(event.depositAmount, tCheckAmount);
      });
      bloc.depositCheckEventPipe.send(UpdateCheckAmountEvent(tCheckAmount));
    });

    test(
        'should update the userEmail and userEmailStatus by UpdateUserEmailEvent func',
        () {
      bloc.depositCheckViewModelPipe.receive.listen((event) {
        expect(event.userEmail, tUserEmail);
        expect(event.userEmailStatus, '');
      });
      bloc.depositCheckEventPipe.send(UpdateUserEmailEvent(tUserEmail));
    });

    test('should update the account info by UpdateAccountInfoEvent func', () {
      bloc.depositCheckViewModelPipe.receive.listen((event) {
        expect(event.accountInfo, tAccountInfo);
      });
      bloc.depositCheckCardEventPipe.send(UpdateAccountInfoEvent(tAccountInfo));
    });

    test('should UpdateCheckImgEvent update the check img', () {
      bloc.depositCheckViewModelPipe.receive.listen((event) {
        expect(event.frontCheckImg, isNotNull);
      });
      bloc.depositCheckEventPipe.send(UpdateCheckImgEvent(tImgType));
    });

    test(
        'should error update the userEmail and userEmailStatus by UpdateUserEmailEvent func',
        () async {
      mockDepositCheckUseCase.updateAmount(10.0);
      bloc.depositCheckEventPipe.send(UpdateCheckAmountEvent(10.0));
      bloc.depositCheckViewModelPipe.receive.listen(
        (event) {
          print(event.depositAmount);
          expect(event.depositAmount, '');
        },
      );
    });
    test('should return probs correctly', () async {
      UpdateCheckAmountEvent updateCheckAmountEvent =
          UpdateCheckAmountEvent(10.0);
      updateCheckAmountEvent.props;
      expect(updateCheckAmountEvent.props, [10.0]);
    });
  });
}
