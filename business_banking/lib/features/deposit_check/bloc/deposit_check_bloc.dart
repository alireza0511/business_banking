import 'package:business_banking/features/deposit_check/model/account_info_struct.dart';
import 'package:business_banking/features/deposit_check/model/deposit_check_card_view_model.dart';
import 'package:business_banking/features/deposit_check/model/deposit_check_confirm_view_model.dart';
import 'package:business_banking/features/deposit_check/model/deposit_check_view_model.dart';
import 'package:clean_framework/clean_framework.dart';

import 'deposit_check_card_usecase.dart';
import 'deposit_check_confirmation_usecase.dart';
import 'deposit_check_event.dart';
import 'deposit_check_usecase.dart';

class DepositCheckBloc extends Bloc {
  DepositCheckCardUseCase? _depositCheckCardUseCase;
  DepositCheckUseCase? _depositCheckUseCase;
  DepositCheckConfirmUseCase? _depositCheckConfirmUseCase;

  final depositCheckEventPipe =
      Pipe<DepositCheckEvent>(canSendDuplicateData: true);

  final depositCheckCardViewModelPipe = Pipe<DepositCheckCardViewModel>();
  final depositCheckViewModelPipe = Pipe<DepositCheckViewModel>();
  final depositCheckConfirmViewModelPipe = Pipe<DepositCheckConfirmViewModel>();

  // final accountInfoPipe = Pipe<AccountInfoStruct>();

  // final amountPipe = Pipe<double>();
  // final emailPipe = Pipe<String>();
  // final frontImgPipe = Pipe<String>();
  // final backImgPipe = Pipe<String>();
  // final imgPipe = Pipe<String>();

  //final submitPipe = EventPipe();
  // final resetViewModelPipe = EventPipe();
  // final resetServiceStatusPipe = EventPipe();

  @override
  void dispose() {
    depositCheckCardViewModelPipe.dispose();
    depositCheckViewModelPipe.dispose();
    depositCheckConfirmViewModelPipe.dispose();

    depositCheckEventPipe.dispose();

    // accountInfoPipe.dispose();

    // se.dispose();

    //submitPipe.dispose();
    // resetViewModelPipe.dispose();
    // resetServiceStatusPipe.dispose();
  }

  DepositCheckBloc(
      {DepositCheckCardUseCase? depositCheckCardUseCase,
      DepositCheckUseCase? depositCheckUseCase,
      DepositCheckConfirmUseCase? depositCheckConfirmUseCase}) {
    _depositCheckCardUseCase = depositCheckCardUseCase ??
        DepositCheckCardUseCase(depositCheckCardViewModelPipe.send);
    depositCheckCardViewModelPipe
        .whenListenedDo(() => _depositCheckCardUseCase!.execute());

    _depositCheckUseCase = depositCheckUseCase ??
        DepositCheckUseCase(depositCheckViewModelPipe.send);
    depositCheckViewModelPipe
        .whenListenedDo(() => _depositCheckUseCase!.execute());

    _depositCheckConfirmUseCase =
        DepositCheckConfirmUseCase(depositCheckConfirmViewModelPipe.send);
    depositCheckConfirmViewModelPipe
        .whenListenedDo(() => _depositCheckConfirmUseCase!.execute());

    depositCheckEventPipe.receive.listen(depositCheckEventPipeHandler);

    // accountInfoPipe.receive.listen(accountInfoPipeHandler);

    //amountPipe.receive.listen(amountPipeHandler);

    //emailPipe.receive.listen(emailPipeHandler);

    //frontImgPipe.receive.listen(frontImgPipeHandler);

    //backImgPipe.receive.listen(backImgPipeHandler);

    //submitPipe.listen(submitHandler);
    // resetViewModelPipe.listen(resetViewModelHandler);
    // resetServiceStatusPipe.listen(resetServiceStatusHandler);
  }

  void depositCheckEventPipeHandler(DepositCheckEvent event) {
    if (event is UpdateCheckAmountEvent) {
      _depositCheckUseCase!.updateAmount(event.checkAmount);
    } else if (event is UpdateUserEmailEvent) {
      _depositCheckUseCase!.updateEmail(event.userEmail);
    } else if (event is UpdateCheckImgEvent) {
      _depositCheckUseCase!.updateImgs(event.imgType);
    } else if (event is SubmitDepositCheckEvent) {
      _depositCheckUseCase!.submitDepositCheck();
    } else if (event is ResetDepositCheckViewModelEvent) {
      _depositCheckConfirmUseCase!.resetViewModel();
    } else if (event is ResetServiceStatusEvent) {
      _depositCheckUseCase!.resetServiceStatus();
    } else if (event is UpdateAccountInfoEvent) {
      _depositCheckUseCase!.updateAccountInfo(event.accountInfo);
    }
  }

  void accountInfoPipeHandler(AccountInfoStruct accountInfo) {
    _depositCheckUseCase!.updateAccountInfo(accountInfo);
  }

  void amountPipeHandler(double amount) {
    _depositCheckUseCase!.updateAmount(amount);
  }

  void emailPipeHandler(String email) {
    _depositCheckUseCase!.updateEmail(email);
  }

  void frontImgPipeHandler(String imgType) {
    _depositCheckUseCase!.updateImgs(imgType);
  }

  void backImgPipeHandler(String imgType) {
    _depositCheckUseCase!.updateImgs(imgType);
  }

  void submitHandler() {
    _depositCheckUseCase!.submitDepositCheck();
  }

  void resetViewModelHandler() {
    //_depositCheckUseCase.resetViewModel();
    _depositCheckConfirmUseCase!.resetViewModel();
  }

  void resetServiceStatusHandler() {
    _depositCheckUseCase!.resetServiceStatus();
  }
}
