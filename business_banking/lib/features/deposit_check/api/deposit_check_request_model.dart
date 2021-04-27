import 'package:clean_framework/clean_framework_defaults.dart';
import 'package:equatable/equatable.dart';

class CheckDepositServiceRequestModel extends Equatable
    implements JsonRequestModel {
  final String accountNumber;
  final double depositAmount;
  final String frontCheckImg;
  final String backCheckImg;

  CheckDepositServiceRequestModel(
      {required this.accountNumber,
      required this.depositAmount,
      required this.frontCheckImg,
      required this.backCheckImg});

  @override
  Map<String, dynamic> toJson() {
    return {
      'accountNumber': accountNumber,
      'depositAmount': depositAmount.toString(),
      'frontCheckImg': frontCheckImg,
      'backCheckImg': backCheckImg
    };
  }

  @override
  List<Object> get props =>
      [accountNumber, depositAmount, frontCheckImg, backCheckImg];
}
