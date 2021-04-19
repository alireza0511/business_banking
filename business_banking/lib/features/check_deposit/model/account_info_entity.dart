import 'package:clean_framework/clean_framework.dart';

class AccountInfoEntity extends Entity {
  final String accountNumber;
  final double availableBalance;
  final String accountNickname;

  AccountInfoEntity(
      {List<EntityFailure> errors = const [],
      this.accountNumber = '',
      this.availableBalance = 0.0,
      this.accountNickname = ''});

  @override
  List<Object> get probs =>
      [errors, accountNumber, availableBalance, accountNickname];

  @override
  AccountInfoEntity merge(
      {List<EntityFailure>? errors,
      String? accountNumber,
      double? availableBalance,
      String? accountNickname}) {
    return AccountInfoEntity(
        errors: errors ?? this.errors,
        accountNumber: accountNumber ?? this.accountNumber,
        availableBalance: availableBalance ?? this.availableBalance,
        accountNickname: accountNickname ?? this.accountNickname);
  }
}
