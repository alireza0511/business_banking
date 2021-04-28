import 'package:equatable/equatable.dart';

import 'package:business_banking/features/deposit_check/model/account_info_struct.dart';

abstract class DepositCheckCardEvent extends Equatable {}

abstract class DepositCheckEvent extends Equatable {}

abstract class DepositCheckConfirmEvent extends Equatable {}

class UpdateCheckAmountEvent implements DepositCheckEvent {
  final double checkAmount;

  UpdateCheckAmountEvent(this.checkAmount);

  @override
  List<Object> get props => [checkAmount];

  @override
  bool get stringify => true;
}

class UpdateUserEmailEvent implements DepositCheckEvent {
  final String userEmail;

  UpdateUserEmailEvent(this.userEmail);

  @override
  List<Object> get props => [userEmail];

  @override
  bool get stringify => true;
}

class UpdateCheckImgEvent implements DepositCheckEvent {
  final String imgType;

  UpdateCheckImgEvent(this.imgType);

  @override
  List<Object> get props => [imgType];

  @override
  bool get stringify => true;
}

class UpdateAccountInfoEvent implements DepositCheckCardEvent {
  final AccountInfoStruct accountInfo;

  UpdateAccountInfoEvent(this.accountInfo);

  @override
  List<Object> get props => [accountInfo];

  @override
  bool get stringify => true;
}

class SubmitDepositCheckEvent implements DepositCheckEvent {
  SubmitDepositCheckEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class ResetDepositCheckViewModelEvent implements DepositCheckConfirmEvent {
  ResetDepositCheckViewModelEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class ResetServiceStatusEvent implements DepositCheckConfirmEvent {
  ResetServiceStatusEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}
