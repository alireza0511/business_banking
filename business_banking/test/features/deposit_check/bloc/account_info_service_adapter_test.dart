// @dart=2.9
import 'package:business_banking/features/deposit_check/api/account_info_response_model.dart';
import 'package:business_banking/features/deposit_check/bloc/1st_hub_card/account_info_service_adapter.dart';
import 'package:business_banking/features/deposit_check/model/account_info_struct.dart';
import 'package:business_banking/features/deposit_check/model/deposit_check_card_entity.dart';
import 'package:test/test.dart';

void main() {
  group('AccountInfo Service Adapter Test', () {
    final tEntity = DepositCheckCardEntity(
        accountInfo: AccountInfoStruct(
            accountNickname: 'Checking Account (...6917)',
            accountNumber: '1234567890126917',
            availableBalance: 481.84,
            depositLimit: 4500.0));

    final tJsonResponse = {
      "accountNumber": "1234567890126917",
      "availableBalance": 481.84,
      "depositLimit": 4500.00,
      "accountNickname": "Checking Account (...6917)"
    };

    test('should received a json responce and return DepositCheckCard entity',
        () async {
      final entity = AccountInfoServiceAdapter().createEntity(
          DepositCheckCardEntity(),
          AccountInfoServiceResponseModel.fromJson(tJsonResponse));
      expect(entity, tEntity);
    });
  });
}
