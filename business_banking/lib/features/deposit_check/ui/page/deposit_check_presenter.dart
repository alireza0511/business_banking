import 'package:business_banking/dependency/Image_picker_plugin.dart';
import 'package:business_banking/dependency/permission_handler_plugin.dart';
import 'package:business_banking/features/deposit_check/bloc/deposit_check_bloc.dart';
import 'package:business_banking/features/deposit_check/model/account_info_view_model.dart';
import 'package:business_banking/features/deposit_check/model/deposit_check_view_model.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/material.dart';

import 'deposit_check_screen.dart';

class DepositCheckPresenter extends Presenter<DepositCheckBloc,
    DepositCheckViewModel, DepositCheckScreen> {
  @override
  Stream<DepositCheckViewModel> getViewModelStream(DepositCheckBloc bloc) {
    //test purpose
    //bloc.frontImgPipe.re;

    return bloc.depositCheckViewModelPipe.receive;
    //return bloc.accountInfoViewModelPipe.receive;
  }

  @override
  void sendViewModelRequest(DepositCheckBloc bloc) {
    // TODO: implement sendViewModelRequest
    super.sendViewModelRequest(bloc);
  }

  @override
  DepositCheckScreen buildScreen(BuildContext context, DepositCheckBloc bloc,
      DepositCheckViewModel viewModel) {
    return DepositCheckScreen(
      viewModel: viewModel,
      pressenterAction: DepositCheckPressenterActions(
          bloc, PermissionHandlerPlugin(), ImagePickerPlugin()),
    );
  }
}

class DepositCheckPressenterActions {
  DepositCheckBloc bloc;
  final PermissionHandlerPlugin _permissionHandlerPluginImpl;
  final ImagePickerPlugin _imagePickerPluginImpl;

  DepositCheckPressenterActions(this.bloc, this._permissionHandlerPluginImpl,
      this._imagePickerPluginImpl);

  popNavigationListener(BuildContext context) {
    CFRouterScope.of(context).pop();
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
    // TODO: regex function handler
    if (value.contains(RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")) ==
        true) {
      return null;
    } else {
      return 'Please, provide a valid email.';
    }
  }

  void onTapConfirm(BuildContext context, DepositCheckViewModel viewModel) {
    bloc.submitPipe.launch();

    // TODO: get ref num from response model
    _showDialog(context, msg: 'Successful! your reference number is ');
  }

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
