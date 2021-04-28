// @dart=2.9
import 'package:business_banking/features/deposit_check/api/deposit_check_response_model.dart';
import 'package:business_banking/features/deposit_check/bloc/2nd_data_entry/deposit_check_service_adapter.dart';
import 'package:business_banking/features/deposit_check/model/account_info_struct.dart';
import 'package:business_banking/features/deposit_check/model/deposit_check_entity.dart';
import 'package:test/test.dart';

void main() {
  group('Deposit check service adapter test', () {
    final tEntity = DepositCheckEntity(
        accountInfo: AccountInfoStruct(
            accountNickname: 'Checking Account (...6917)',
            accountNumber: '1234567890126917',
            availableBalance: 481.84,
            depositLimit: 4500.0),
        referenceNumber: '123456789');

    final tJsonResponse = {
      "status": "Successful",
      "didSucceed": true,
      "referenceNumber": "123456789"
    };

    test('should received a json responce and return reference number',
        () async {
      final entity = DepositCheckServiceAdapter().createEntity(
          DepositCheckEntity(),
          DepositCheckServiceResponseModel.fromJson(tJsonResponse));
      expect(entity, tEntity);
    });
  });
}
