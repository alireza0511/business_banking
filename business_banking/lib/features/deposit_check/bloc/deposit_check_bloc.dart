import 'package:business_banking/features/deposit_check/bloc/account_info_usecase.dart';
import 'package:business_banking/features/deposit_check/model/account_info_view_model.dart';
import 'package:business_banking/features/deposit_check/model/deposit_check_view_model.dart';
import 'package:clean_framework/clean_framework.dart';

import 'deposit_check_usecase.dart';

class DepositCheckBloc extends Bloc {
  late final DepositCheckUseCase _useCase;
  final depositCheckViewModelPipe = Pipe<DepositCheckViewModel>();
  final acountInfoViewModelPipe = Pipe<AccountInfoViewModel>();
  final submitPipe = EventPipe();

  @override
  void dispose() {
    depositCheckViewModelPipe.dispose();
    acountInfoViewModelPipe.dispose();
    submitPipe.dispose();
  }

  DepositCheckBloc() {
    _useCase = DepositCheckUseCase(depositCheckViewModelPipe.send);

    submitPipe.listen(submitHandler);
  }

  void submitHandler() {}
}
