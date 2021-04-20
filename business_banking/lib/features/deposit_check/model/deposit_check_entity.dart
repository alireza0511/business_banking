import 'package:clean_framework/clean_framework.dart';

class DepositCheckEntity extends Entity {
  final String accountNumber;
  final double depositAmount;
  final String frontCheckImg;
  final String backCheckImg;

  DepositCheckEntity(
      {List<EntityFailure> errors = const [],
      this.accountNumber = '',
      this.depositAmount = 0.0,
      this.frontCheckImg = '',
      this.backCheckImg = ''});

  @override
  List<Object> get probs =>
      [errors, accountNumber, depositAmount, frontCheckImg, backCheckImg];

  @override
  DepositCheckEntity merge(
      {List<EntityFailure>? errors,
      String? accountNumber,
      double? depositAmount,
      String? frontCheckImg,
      String? backCheckImg}) {
    return DepositCheckEntity(
        errors: errors ?? this.errors,
        accountNumber: accountNumber ?? this.accountNumber,
        depositAmount: depositAmount ?? this.depositAmount,
        frontCheckImg: frontCheckImg ?? this.frontCheckImg,
        backCheckImg: backCheckImg ?? this.backCheckImg);
  }
}
