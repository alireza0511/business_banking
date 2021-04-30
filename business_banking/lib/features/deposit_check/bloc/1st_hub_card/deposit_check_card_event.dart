import 'package:equatable/equatable.dart';

import 'package:business_banking/features/deposit_check/model/account_info_struct.dart';

abstract class DepositCheckCardEvent extends Equatable {}

class UpdateAccountInfoEvent implements DepositCheckCardEvent {
  final AccountInfoStruct accountInfo;

  UpdateAccountInfoEvent(this.accountInfo);

  @override
  List<Object> get props => [accountInfo];

  @override
  bool get stringify => true;
}
