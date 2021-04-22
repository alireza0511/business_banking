import 'package:clean_framework/clean_framework.dart';

class AccountInfoEntity extends Entity {
  final String accountNumber;
  final double availableBalance;
  final double depositLimit;
  final String accountNickname;

  AccountInfoEntity(
      {List<EntityFailure> errors = const [],
      this.accountNumber = '',
      this.availableBalance = 0.0,
      this.depositLimit = 0.0,
      this.accountNickname = ''});

  @override
  List<Object> get probs =>
      [errors, accountNumber, availableBalance, depositLimit, accountNickname];

  @override
  AccountInfoEntity merge(
      {List<EntityFailure>? errors,
      String? accountNumber,
      double? availableBalance,
      double? depositLimit,
      String? accountNickname}) {
    return AccountInfoEntity(
        errors: errors ?? this.errors,
        accountNumber: accountNumber ?? this.accountNumber,
        availableBalance: availableBalance ?? this.availableBalance,
        depositLimit: depositLimit ?? this.depositLimit,
        accountNickname: accountNickname ?? this.accountNickname);
  }
}
