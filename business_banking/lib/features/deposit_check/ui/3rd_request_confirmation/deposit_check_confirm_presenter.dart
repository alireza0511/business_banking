import 'package:business_banking/features/deposit_check/bloc/deposit_check_bloc.dart';
import 'package:business_banking/features/deposit_check/model/deposit_check_confirm_view_model.dart';
import 'package:business_banking/features/deposit_check/bloc/deposit_check_event.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/material.dart';

import '../../../../routes.dart';
import 'deposit_check_confirm_screen.dart';

class DepositCheckConfirmPresenter extends Presenter<DepositCheckBloc,
    DepositCheckConfirmViewModel, DepositCheckConfirmScreen> {
  @override
  Stream<DepositCheckConfirmViewModel> getViewModelStream(
      DepositCheckBloc bloc) {
    return bloc.depositCheckConfirmViewModelPipe.receive;
  }

  @override
  DepositCheckConfirmScreen buildScreen(BuildContext context,
      DepositCheckBloc bloc, DepositCheckConfirmViewModel viewModel) {
    return DepositCheckConfirmScreen(
      viewModel: viewModel,
      pressenterAction: DepositCheckConfirmPressenterActions(bloc),
    );
  }
}

class DepositCheckConfirmPressenterActions {
  DepositCheckBloc bloc;
  DepositCheckConfirmPressenterActions(this.bloc);

  popNavigationListener(BuildContext context) {
    // bloc.resetServiceStatusPipe.launch();
    //bloc.resetViewModelPipe.launch();
    bloc.depositCheckConfirmEventPipe.send(ResetDepositCheckViewModelEvent());
    CFRouterScope.of(context).popUntil(BusinessBankingRouter.hubRoute);
  }
}
