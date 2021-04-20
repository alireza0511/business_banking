import 'package:business_banking/features/deposit_check/bloc/account_info_bloc.dart';
import 'package:business_banking/features/deposit_check/bloc/deposit_check_bloc.dart';
import 'package:business_banking/features/deposit_check/model/account_info_view_model.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/material.dart';

import '../../../routes.dart';
import 'deposit_check_card_screen.dart';

class DepositCheckCardPresenter extends Presenter<AccountInfoBloc,
    AccountInfoViewModel, DepositCheckCardScreen> {
  @override
  Stream<AccountInfoViewModel> getViewModelStream(AccountInfoBloc bloc) {
    return bloc.accountInfoViewModelPipe.receive;
  }

  @override
  DepositCheckCardScreen buildScreen(BuildContext context, AccountInfoBloc bloc,
      AccountInfoViewModel viewModel) {
    return DepositCheckCardScreen(
      viewModel: viewModel,
      navigateToDepositCheck: () {
        _navigateToFeature(context);
      },
    );
  }

  void _navigateToFeature(BuildContext context) {
    CFRouterScope.of(context).push(BusinessBankingRouter.depositCheckRoute);
  }
}
