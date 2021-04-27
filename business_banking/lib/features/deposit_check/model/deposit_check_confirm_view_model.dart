import 'package:business_banking/features/deposit_check/model/account_info_struct.dart';
import 'package:clean_framework/clean_framework.dart';

class DepositCheckConfirmViewModel extends ViewModel {
  final AccountInfoStruct accountInfo;
  final double depositAmount;
  final String frontCheckImg;
  final String backCheckImg;
  final String referenceNumber;
  final serviceResponseStatus;

  DepositCheckConfirmViewModel(
      {required this.accountInfo,
      required this.depositAmount,
      required this.frontCheckImg,
      required this.backCheckImg,
      required this.referenceNumber,
      required this.serviceResponseStatus});

  @override
  List<Object> get props => [
        accountInfo,
        depositAmount,
        frontCheckImg,
        backCheckImg,
        referenceNumber,
      ];
}
