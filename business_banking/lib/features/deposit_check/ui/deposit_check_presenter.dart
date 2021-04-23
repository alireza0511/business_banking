import 'package:business_banking/dependency/Image_picker_plugin.dart';
import 'package:business_banking/dependency/permission_handler_plugin.dart';
import 'package:business_banking/features/deposit_check/bloc/deposit_check_bloc.dart';
import 'package:business_banking/features/deposit_check/model/deposit_check_view_model.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/material.dart';

import '../../../routes.dart';
import 'deposit_check_screen.dart';

class DepositCheckPresenter extends Presenter<DepositCheckBloc,
    DepositCheckViewModel, DepositCheckScreen> {
  @override
  Stream<DepositCheckViewModel> getViewModelStream(DepositCheckBloc bloc) {
    return bloc.depositCheckViewModelPipe.receive;
  }

  @override
  DepositCheckScreen buildScreen(BuildContext context, DepositCheckBloc bloc,
      DepositCheckViewModel viewModel) {
    return DepositCheckScreen(
      viewModel: viewModel,
      pressenterAction: DepositCheckPressenterActions(
        bloc,
      ),
    );
  }
}

class DepositCheckPressenterActions {
  DepositCheckBloc bloc;

  DepositCheckPressenterActions(this.bloc);

  popNavigationListener(BuildContext context) {
    CFRouterScope.of(context).pop();
  }

  navigateToDepositCheckConfirm(BuildContext context) {
    CFRouterScope.of(context)
        .push(BusinessBankingRouter.depositCheckConfirmRoute);
  }

  /// The email just added to check RegEx
  onFormSavedListener(String emailString) {
    // TODO : do nothing
    print(emailString);
  }

  onDepositCheckAmountSavedListener(String amountString) {
    double? amount = double.tryParse(amountString);
    if (amountString == '' || (amount != null && amount > 0)) {
      bloc.amountPipe.send(amountString);
    }
  }

//? can I have regExp in presenterActions
  onRegExValidation(String value) {
    if (value.contains(RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")) ==
        true) {
      return null;
    } else {
      return 'Please, provide a valid email.';
    }
  }

  void onTapConfirmBtn(BuildContext context, GlobalKey<FormState> form) {
    if (form.currentState != null) {
      final isValid = form.currentState!.validate();
      if (isValid == false) return;
      form.currentState!.save();

      bloc.submitPipe.launch();

      navigateToDepositCheckConfirm(context);
    }
  }

  /// listens User action on pick front image of check
  void onPickFrontImg() async {
    bloc.frontImgPipe.send('front');
  }

  void onPickBackImg() async {
    bloc.backImgPipe.send('back');
  }

  void _showDialog(BuildContext context,
      {String title = 'Response', String msg = 'Successful!'}) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(msg),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              CFRouterScope.of(context).pop();
            },
            child: Text('OK'),
          )
        ],
      ),
    );
  }
}
