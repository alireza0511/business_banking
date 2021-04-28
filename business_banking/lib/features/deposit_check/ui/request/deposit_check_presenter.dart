import 'package:business_banking/dependency/Image_picker_plugin.dart';
import 'package:business_banking/dependency/permission_handler_plugin.dart';
import 'package:business_banking/features/deposit_check/bloc/deposit_check_bloc.dart';
import 'package:business_banking/features/deposit_check/bloc/deposit_check_event.dart';
import 'package:business_banking/features/deposit_check/model/deposit_check_view_model.dart';
import 'package:business_banking/features/deposit_check/model/enums.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../../../routes.dart';
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
    // SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
    //   if (viewModel.serviceResponseStatus == ServiceResponseStatus.succeed) {
    //     //pressenterAction.navigateToDepositCheckConfirm(context);
    //     CFRouterScope.of(context)
    //         .push(BusinessBankingRouter.depositCheckConfirmRoute);
    //   } else if (viewModel.serviceResponseStatus !=
    //           ServiceResponseStatus.succeed &&
    //       viewModel.userInputStatus == UserInputStatus.valid) {
    //     _showErrorDialog(context, bloc);
    //   }
    // });

    return DepositCheckScreen(
      viewModel: viewModel,
      pressenterAction: DepositCheckPressenterActions(
        bloc,
      ),
    );
  }

  // void _showErrorDialog(BuildContext context, DepositCheckBloc bloc) {
  //   showDialog(
  //     context: context,
  //     builder: (_) => AlertDialog(
  //       title: Text('Error'),
  //       content: Text('Submit Failed'),
  //       actions: <Widget>[
  //         TextButton(
  //           onPressed: () {
  //             bloc.resetServiceStatusPipe.launch();
  //             Navigator.of(context).pop();
  //             // CFRouterScope.of(context).pop();
  //           },
  //           child: Text('OK'),
  //         )
  //       ],
  //     ),
  //   );
  // }

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

  /// listens saved action on User email
  onUserEmailSavedListener(String emailString) {
    if (emailString.isNotEmpty) {
      bloc.depositCheckEventPipe.send(UpdateUserEmailEvent(emailString));
    }
  }

  /// listens saved action on Deposit Amount
  onDepositCheckAmountSavedListener(String amountString) {
    double? amount = double.tryParse(amountString);
    if (amountString.isNotEmpty && (amount != null && amount > 0)) {
      bloc.depositCheckEventPipe.send(UpdateCheckAmountEvent(amount));
    }
  }

  /// listens action on pick front image of check
  void onPickFrontImg() async {
    // bloc.frontImgPipe.send('front');
    bloc.depositCheckEventPipe.send(UpdateCheckImgEvent('front'));
  }

  /// listens action on pick back image of check
  void onPickBackImg() async {
    // bloc.backImgPipe.send('back');
    bloc.depositCheckEventPipe.send(UpdateCheckImgEvent('back'));
  }

  /// listens action on Confirm Button
  void onTapConfirmBtn(BuildContext context, GlobalKey<FormState> form,
      DepositCheckViewModel viewModel) {
    if (form.currentState != null) {
      final isValid = form.currentState!.validate();
      if (isValid == false) return;
      form.currentState!.save();
      if (viewModel.userInputStatus == UserInputStatus.valid) {
        bloc.depositCheckEventPipe.send(SubmitDepositCheckEvent());
        // bloc.submitPipe.launch();

        navigateToDepositCheckConfirm(context);
      } else {
        _showErrorDialog(context);
      }
    }
  }

  void _showErrorDialog(BuildContext context,
      {String title = 'Invalid', String msg = 'Please fill all fields.'}) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(msg),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          )
        ],
      ),
    );
  }

  void showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Error'),
        content: Text('Submit Failed'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              //bloc.resetServiceStatusPipe.launch();
              Navigator.of(context).pop();
              // CFRouterScope.of(context).pop();
            },
            child: Text('OK'),
          )
        ],
      ),
    );
  }
}
