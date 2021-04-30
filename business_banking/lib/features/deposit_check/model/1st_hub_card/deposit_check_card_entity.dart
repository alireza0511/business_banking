import 'package:business_banking/features/deposit_check/model/account_info_struct.dart';
import 'package:clean_framework/clean_framework.dart';

class DepositCheckCardEntity extends Entity {
  final AccountInfoStruct accountInfo;

  DepositCheckCardEntity({
    List<EntityFailure> errors = const [],
    AccountInfoStruct? accountInfo,
  })  : accountInfo = accountInfo ??
            AccountInfoStruct(
                accountNickname: '',
                accountNumber: '',
                availableBalance: 0.0,
                depositLimit: 0.0),
        super(errors: errors);

  @override
  List<Object> get props => [errors, accountInfo];

  @override
  DepositCheckCardEntity merge({
    List<EntityFailure>? errors,
    AccountInfoStruct? accountInfo,
  }) {
    return DepositCheckCardEntity(
      errors: errors ?? this.errors,
      accountInfo: accountInfo ?? this.accountInfo,
    );
  }
}
