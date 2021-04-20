import 'package:business_banking/features/deposit_check/bloc/account_info_bloc.dart';
import 'package:business_banking/features/deposit_check/model/account_info_view_model.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/material.dart';

import 'deposit_check_screen.dart';

class DepositCheckPresenter extends Presenter<AccountInfoBloc,
    AccountInfoViewModel, DepositCheckScreen> {
  @override
  Stream<AccountInfoViewModel> getViewModelStream(AccountInfoBloc bloc) {
    return bloc.accountInfoViewModelPipe.receive;
  }

  @override
  DepositCheckScreen buildScreen(BuildContext context, AccountInfoBloc bloc,
      AccountInfoViewModel viewModel) {
    return DepositCheckScreen(
      viewModel: viewModel,
      navigateToDepositCheckDetail: () {
        //context.router.push(Routes.payment);s
      },
    );
  }
}

class PressenterAction {
  popNavigationListener() {}
}
