import 'package:business_banking/features/deposit_check/bloc/deposit_check_bloc.dart';
import 'package:business_banking/features/deposit_check/model/deposit_check_view_model.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/material.dart';

import '../../../routes.dart';
import 'deposit_check_confirm_screen.dart';

class DepositCheckConfirmPresenter extends Presenter<DepositCheckBloc,
    DepositCheckViewModel, DepositCheckConfirmScreen> {
  @override
  Stream<DepositCheckViewModel> getViewModelStream(DepositCheckBloc bloc) {
    return bloc.depositCheckViewModelPipe.receive;
  }

  @override
  DepositCheckConfirmScreen buildScreen(BuildContext context,
      DepositCheckBloc bloc, DepositCheckViewModel viewModel) {
    return DepositCheckConfirmScreen(
      viewModel: viewModel,
      pressenterAction: DepositCheckConfirmPressenterActions(),
    );
  }
}

class DepositCheckConfirmPressenterActions {
  DepositCheckConfirmPressenterActions();

  popNavigationListener(BuildContext context) {
    CFRouterScope.of(context).popUntil(BusinessBankingRouter.hubRoute);
  }
}
