import 'package:business_banking/features/deposit_check/bloc/deposit_check_bloc.dart';
import 'package:business_banking/features/deposit_check/model/1st_hub_card/deposit_check_card_view_model.dart';
import 'package:business_banking/features/deposit_check/model/2nd_data_entry/deposit_check_view_model.dart';
import 'package:business_banking/features/deposit_check/model/3rd_request_confirmation/deposit_check_confirm_view_model.dart';
import 'package:business_banking/features/deposit_check/model/account_info_struct.dart';
import 'package:business_banking/features/deposit_check/model/enums.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:mockito/mockito.dart';

class DepositCheckBlockMock extends Mock implements DepositCheckBloc {
  @override
  Pipe<DepositCheckCardViewModel> depositCheckCardViewModelPipe =
      Pipe<DepositCheckCardViewModel>();

  Pipe<DepositCheckViewModel> depositCheckViewModelPipe =
      Pipe<DepositCheckViewModel>();

  Pipe<DepositCheckConfirmViewModel> depositCheckConfirmViewModelPipe =
      Pipe<DepositCheckConfirmViewModel>();

  DepositCheckCardViewModel depositCheckCardViewModelSample =
      DepositCheckCardViewModel(
    accountInfo: AccountInfoStruct(
        accountNickname: '',
        accountNumber: '',
        availableBalance: 0.0,
        depositLimit: 0.0),
  );

  DepositCheckViewModel depositCheckViewModelSample = DepositCheckViewModel(
      accountInfo: AccountInfoStruct(
          accountNickname: '',
          accountNumber: '',
          availableBalance: 0.0,
          depositLimit: 0.0),
      backCheckImg: '',
      depositAmount: 0.0,
      frontCheckImg: '',
      referenceNumber: '',
      userEmail: '');

  DepositCheckConfirmViewModel depositCheckConfirmViewModelSample =
      DepositCheckConfirmViewModel(
          accountInfo: AccountInfoStruct(
              accountNickname: '',
              accountNumber: '',
              availableBalance: 0.0,
              depositLimit: 0.0),
          backCheckImg: '',
          depositAmount: 0.0,
          frontCheckImg: '',
          referenceNumber: '',
          serviceResponseStatus: ServiceResponseStatus.unknown);

  DepositCheckBlockMock() {
    depositCheckCardViewModelPipe.whenListenedDo(() {
      depositCheckCardViewModelPipe.send(
        depositCheckCardViewModelSample,
      );
    });

    depositCheckViewModelPipe.whenListenedDo(() {
      depositCheckViewModelPipe.send(
        depositCheckViewModelSample,
      );
    });

    depositCheckConfirmViewModelPipe.whenListenedDo(() {
      depositCheckConfirmViewModelPipe.send(
        depositCheckConfirmViewModelSample,
      );
    });
  }
}
