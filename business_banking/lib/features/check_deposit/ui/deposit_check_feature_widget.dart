import 'package:flutter/material.dart';
import 'package:clean_framework/clean_framework.dart';

class DepositCheckFeatureWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<InvestmentBloc>(
      create: (_) => InvestmentBloc(),
      child: InvestmentPresenter(),
    );
  }
}
