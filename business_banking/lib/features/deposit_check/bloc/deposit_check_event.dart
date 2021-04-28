import 'package:equatable/equatable.dart';

import 'package:business_banking/features/deposit_check/model/account_info_struct.dart';

abstract class DepositCheckEvent extends Equatable {}

class UpdateCheckAmountEvent implements DepositCheckEvent {
  final double checkAmount;

  UpdateCheckAmountEvent(this.checkAmount);

  @override
  List<Object> get props => [checkAmount];

  @override
  bool get stringify => true;

  @override
  String toString() => 'UpdatCheckAmount(checkAmount: $checkAmount)';
}

class UpdateUserEmailEvent implements DepositCheckEvent {
  final String userEmail;

  UpdateUserEmailEvent(this.userEmail);

  @override
  List<Object> get props => [userEmail];

  @override
  bool get stringify => true;

  @override
  String toString() => 'UpdateUserEmailEvent(userEmail: $userEmail)';
}

class UpdateCheckImgEvent implements DepositCheckEvent {
  final String imgType;

  UpdateCheckImgEvent(this.imgType);

  @override
  List<Object> get props => [imgType];

  @override
  bool get stringify => true;

  @override
  String toString() => 'UpdateCheckImgEvent(imgType: $imgType)';
}

class UpdateAccountInfoEvent implements DepositCheckEvent {
  final AccountInfoStruct accountInfo;

  UpdateAccountInfoEvent(this.accountInfo);

  @override
  List<Object> get props => [accountInfo];

  @override
  bool get stringify => true;

  @override
  String toString() => 'UpdateAccountInfoEvent(accountInfo: $accountInfo)';
}

class SubmitDepositCheckEvent implements DepositCheckEvent {
  SubmitDepositCheckEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;

  @override
  String toString() => 'SubmitDepositCheckEvent';
}

class ResetDepositCheckViewModelEvent implements DepositCheckEvent {
  ResetDepositCheckViewModelEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;

  @override
  String toString() => 'ResetDepositCheckViewModelEvent';
}

class ResetServiceStatusEvent implements DepositCheckEvent {
  ResetServiceStatusEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;

  @override
  String toString() => 'ResetServiceStatusEvent';
}
