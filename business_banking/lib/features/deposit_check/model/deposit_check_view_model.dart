import 'dart:typed_data';

import 'package:business_banking/features/deposit_check/model/account_info_struct.dart';
import 'package:clean_framework/clean_framework.dart';

class DepositCheckViewModel extends ViewModel {
  final AccountInfoStruct? accountInfo;
  final String depositAmount;
  final String frontCheckImg;
  final String backCheckImg;
  final String referenceNumber;

  DepositCheckViewModel(
      {required this.accountInfo,
      required this.depositAmount,
      required this.frontCheckImg,
      required this.backCheckImg,
      required this.referenceNumber});

  @override
  List<Object> get props => [
        accountInfo!,
        depositAmount,
        frontCheckImg,
        backCheckImg,
        referenceNumber
      ];
}
