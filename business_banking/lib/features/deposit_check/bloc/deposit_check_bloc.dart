import 'dart:typed_data';

import 'package:business_banking/features/deposit_check/bloc/account_info_usecase.dart';
import 'package:business_banking/features/deposit_check/model/account_info_view_model.dart';
import 'package:business_banking/features/deposit_check/model/deposit_check_view_model.dart';
import 'package:clean_framework/clean_framework.dart';

import 'deposit_check_usecase.dart';

class DepositCheckBloc extends Bloc {
  late final DepositCheckUseCase _depositCheckUseCase;
  final depositCheckViewModelPipe = Pipe<DepositCheckViewModel>();

  late final AccountInfoUseCase _accountInfoUseCase;
  final accountInfoViewModelPipe = Pipe<AccountInfoViewModel>();

  final amountPipe = Pipe<String>();
  final emailPipe = Pipe<String>();
  final frontImgPipe = Pipe<String>();
  final backImgPipe = Pipe<String>();

  final submitPipe = EventPipe();

  @override
  void dispose() {
    depositCheckViewModelPipe.dispose();
    accountInfoViewModelPipe.dispose();
    submitPipe.dispose();
    emailPipe.dispose();
    amountPipe.dispose();
    frontImgPipe.dispose();
    backImgPipe.dispose();
  }

  DepositCheckBloc() {
    _depositCheckUseCase = DepositCheckUseCase(depositCheckViewModelPipe.send);
    depositCheckViewModelPipe
        .whenListenedDo(() => _depositCheckUseCase.execute());

    _accountInfoUseCase = AccountInfoUseCase(accountInfoViewModelPipe.send);
    accountInfoViewModelPipe
        .whenListenedDo(() => _accountInfoUseCase.execute());

    amountPipe.receive.listen(amountPipeHandler);

    frontImgPipe.receive.listen(frontImgPipeHandler);

    backImgPipe.receive.listen(backImgPipeHandler);

    submitPipe.listen(submitHandler);
  }

  void submitHandler() {
    _depositCheckUseCase.confirmDepositCheck();
  }

  void amountPipeHandler(String amount) {
    _depositCheckUseCase.updateAmount(amount);
  }

  void frontImgPipeHandler(String imgType) {
    _depositCheckUseCase.updateImgs(imgType);
  }

  void backImgPipeHandler(String imgType) {
    _depositCheckUseCase.updateImgs(imgType);
  }
}
