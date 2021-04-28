import 'package:business_banking/features/deposit_check/model/account_info_struct.dart';
import 'package:clean_framework/clean_framework.dart';

import 'enums.dart';

class DepositCheckCardViewModel extends ViewModel {
  final AccountInfoStruct accountInfo;
  final serviceResponseStatus;

  DepositCheckCardViewModel(
      {required this.accountInfo,
      this.serviceResponseStatus = ServiceResponseStatus.unknown});

  @override
  List<Object> get props => [accountInfo];
}
