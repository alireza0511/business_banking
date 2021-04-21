import 'package:business_banking/features/deposit_check/bloc/deposit_check_bloc.dart';
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
    accountNumber: '',
    backCheckImg: '',
    depositAmount: '',
    frontCheckImg: '',
  );

  InvestmentBlockMock() {
    depositCheckViewModelPipe.whenListenedDo(() {
      depositCheckViewModelPipe.send(
        depositCheckViewModelSample,
      );
    });
  }
}
