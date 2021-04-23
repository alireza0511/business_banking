import 'package:clean_framework/clean_framework_defaults.dart';

class AccountInfoServiceResponseModel extends JsonResponseModel {
  final String accountNumber;
  final double availableBalance;
  final double depositLimit;
  final String accountNickname;

  AccountInfoServiceResponseModel.fromJson(Map<String, dynamic> json)
      : accountNumber = json['accountNumber'] ?? '',
        availableBalance = json['availableBalance'] ?? 0.00,
        depositLimit = json['depositLimit'] ?? 0.00,
        accountNickname = json['accountNickname'] ?? '';

  @override
  List<Object> get props => [accountNumber, availableBalance, accountNickname];
}
