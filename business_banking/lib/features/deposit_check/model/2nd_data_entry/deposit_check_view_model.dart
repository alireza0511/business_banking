import 'dart:typed_data';

import 'package:business_banking/features/deposit_check/model/account_info_struct.dart';
import 'package:clean_framework/clean_framework.dart';

import '../enums.dart';

class DepositCheckViewModel extends ViewModel {
  final AccountInfoStruct? accountInfo;
  final double depositAmount;
  final String frontCheckImg;
  final String backCheckImg;
  final String referenceNumber;
  final String userEmail;
  final String? userEmailStatus;
  final String? depositAmountStatus;
  final userInputStatus;
  final serviceResponseStatus;

  DepositCheckViewModel(
      {required this.accountInfo,
      required this.depositAmount,
      required this.frontCheckImg,
      required this.backCheckImg,
      required this.referenceNumber,
      required this.userEmail,
      this.userEmailStatus,
      this.depositAmountStatus,
      this.userInputStatus = UserInputStatus.unknown,
      this.serviceResponseStatus = ServiceResponseStatus.unknown});

  @override
  List<Object> get props => [
        accountInfo!,
        depositAmount,
        userEmail,
        frontCheckImg,
        backCheckImg,
        referenceNumber,
      ];
}
