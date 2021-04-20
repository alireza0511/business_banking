import 'package:business_banking/features/deposit_check/bloc/account_info_usecase.dart';
import 'package:business_banking/features/deposit_check/model/account_info_view_model.dart';
import 'package:business_banking/features/deposit_check/model/deposit_check_view_model.dart';
import 'package:clean_framework/clean_framework.dart';

class AccountInfoBloc extends Bloc {
  late final AccountInfoUseCase _useCase;
  final accountInfoViewModelPipe = Pipe<AccountInfoViewModel>();

  @override
  void dispose() {
    accountInfoViewModelPipe.dispose();
  }

  AccountInfoBloc() {
    _useCase = AccountInfoUseCase(accountInfoViewModelPipe.send);
    accountInfoViewModelPipe.whenListenedDo(() => _useCase.execute());
  }
}
