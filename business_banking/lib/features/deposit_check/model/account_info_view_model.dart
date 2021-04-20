import 'package:clean_framework/clean_framework.dart';

class AccountInfoViewModel extends ViewModel {
  final String accountNumber;
  final double availableBalance;
  final String accountNickname;

  AccountInfoViewModel(
      {required this.accountNumber,
      required this.availableBalance,
      required this.accountNickname});

  @override
  List<Object> get props => [accountNumber, availableBalance, accountNickname];
}
