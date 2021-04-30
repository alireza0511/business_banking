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

  DepositCheckEntity({
    List<EntityFailure> errors = const [],
    AccountInfoStruct? accountInfo,
    this.depositAmount = 0.0,
    this.frontCheckImg = '',
    this.backCheckImg = '',
    this.referenceNumber = '',
    this.userEmail = '',
  })  : accountInfo = accountInfo,
        super(errors: errors);

  @override
  List<Object> get props => [
        errors,
        accountInfo!,
        depositAmount,
        userEmail,
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
  }) {
    return DepositCheckEntity(
      errors: errors ?? this.errors,
      accountInfo: accountInfo ?? this.accountInfo,
      depositAmount: depositAmount ?? this.depositAmount,
      frontCheckImg: frontCheckImg ?? this.frontCheckImg,
      backCheckImg: backCheckImg ?? this.backCheckImg,
      referenceNumber: referenceNumber ?? this.referenceNumber,
      userEmail: userEmail ?? this.userEmail,
    );
  }
}
