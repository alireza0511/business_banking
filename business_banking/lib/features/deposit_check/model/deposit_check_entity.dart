import 'dart:typed_data';

import 'package:business_banking/features/deposit_check/model/account_info_struct.dart';
import 'package:clean_framework/clean_framework.dart';

class DepositCheckEntity extends Entity {
  final AccountInfoStruct? accountInfo;
  final double depositAmount;
  final String frontCheckImg;
  final String backCheckImg;
  final String? referenceNumber;
  final String userEmail;
  //final String? userEmailStatus;
  //final String? depositAmountStatus;

  DepositCheckEntity({
    List<EntityFailure> errors = const [],
    AccountInfoStruct? accountInfo,
    this.depositAmount = 0.0,
    this.frontCheckImg = '',
    this.backCheckImg = '',
    this.referenceNumber = '',
    this.userEmail = '',
    //  this.userEmailStatus = '',
    //this.depositAmountStatus = ''
  })  : accountInfo = accountInfo,
        super(errors: errors);

  @override
  List<Object> get probs => [
        errors,
        accountInfo!,
        depositAmount,
        frontCheckImg,
        backCheckImg,
        referenceNumber!
      ];

  @override
  DepositCheckEntity merge({
    List<EntityFailure>? errors,
    AccountInfoStruct? accountInfo,
    double? depositAmount,
    String? frontCheckImg,
    String? backCheckImg,
    String? referenceNumber,
    String? userEmail,
    // String? userEmailStatus,
    // String? depositAmountStatus,
  }) {
    return DepositCheckEntity(
      errors: errors ?? this.errors,
      accountInfo: accountInfo ?? this.accountInfo,
      depositAmount: depositAmount ?? this.depositAmount,
      frontCheckImg: frontCheckImg ?? this.frontCheckImg,
      backCheckImg: backCheckImg ?? this.backCheckImg,
      referenceNumber: referenceNumber ?? this.referenceNumber,
      userEmail: userEmail ?? this.userEmail,
      // userEmailStatus: userEmailStatus ?? this.userEmailStatus,
      // sdepositAmountStatus: depositAmountStatus ?? this.depositAmountStatus
    );
  }
}
