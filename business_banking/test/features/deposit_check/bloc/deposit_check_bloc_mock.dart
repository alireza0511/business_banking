import 'package:business_banking/features/deposit_check/bloc/deposit_check_bloc.dart';
import 'package:business_banking/features/deposit_check/model/account_info_struct.dart';
import 'package:business_banking/features/deposit_check/model/deposit_check_view_model.dart';
import 'package:business_banking/features/investment/bloc/investment_bloc.dart';
import 'package:business_banking/features/investment/model/investment_view_model.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:mockito/mockito.dart';

class DepositCheckBlockMock extends Mock implements DepositCheckBloc {
  @override
  Pipe<DepositCheckViewModel> depositCheckViewModelPipe =
      Pipe<DepositCheckViewModel>();

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

  DepositCheckBlockMock() {
    depositCheckViewModelPipe.whenListenedDo(() {
      depositCheckViewModelPipe.send(
        depositCheckViewModelSample,
      );
    });
  }
}
