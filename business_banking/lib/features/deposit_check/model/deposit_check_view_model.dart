import 'package:clean_framework/clean_framework.dart';

class DepositCheckViewModel extends ViewModel {
  final String accountNumber;
  final double depositAmount;
  final String frontCheckImg;
  final String backCheckImg;

  DepositCheckViewModel(
      {required this.accountNumber,
      required this.depositAmount,
      required this.frontCheckImg,
      required this.backCheckImg});

  @override
  List<Object> get props =>
      [accountNumber, depositAmount, frontCheckImg, backCheckImg];
}
