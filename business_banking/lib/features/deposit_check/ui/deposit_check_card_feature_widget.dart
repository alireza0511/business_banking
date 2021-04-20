import 'package:business_banking/features/deposit_check/bloc/account_info_bloc.dart';
import 'package:business_banking/features/deposit_check/bloc/deposit_check_bloc.dart';
import 'package:flutter/material.dart';
import 'package:clean_framework/clean_framework.dart';

import 'deposit_check_hub_presenter.dart';

class DepositCheckCardFeatureWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AccountInfoBloc>(
      create: (_) => AccountInfoBloc(),
      child: DepositCheckCardPresenter(),
    );
  }
}
