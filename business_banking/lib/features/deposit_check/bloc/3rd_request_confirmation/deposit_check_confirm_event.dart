import 'package:equatable/equatable.dart';

import 'package:business_banking/features/deposit_check/model/account_info_struct.dart';

abstract class DepositCheckConfirmEvent extends Equatable {}

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
