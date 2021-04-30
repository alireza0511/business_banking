// @dart=2.9
import 'package:business_banking/features/deposit_check/api/deposit_check_request_model.dart';
import 'package:business_banking/features/deposit_check/api/deposit_check_response_model.dart';
import 'package:business_banking/features/deposit_check/bloc/2nd_data_entry/deposit_check_service_adapter.dart';
import 'package:business_banking/features/deposit_check/model/2nd_data_entry/deposit_check_entity.dart';
import 'package:business_banking/features/deposit_check/model/account_info_struct.dart';
import 'package:test/test.dart';

void main() {
  group('Deposit check service adapter test', () {
    final tAccountInfo = AccountInfoStruct(
        accountNickname: 'Checking Account (...6917)',
        accountNumber: '1234567890126917',
        availableBalance: 481.84,
        depositLimit: 4500.0);
    final tInitEntity = DepositCheckEntity(
        accountInfo: tAccountInfo, referenceNumber: '123456789');

    final tEntity = DepositCheckEntity(
        accountInfo: tAccountInfo,
        depositAmount: 200.0,
        frontCheckImg: 'front',
        backCheckImg: 'back',
        referenceNumber: '123456789');

    final tRequestModel = DepositCheckServiceRequestModel(
        accountNumber: '1234567890126917',
        depositAmount: 200.0,
        frontCheckImg: 'front',
        backCheckImg: 'back');

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
      expect(entity.referenceNumber, tInitEntity.referenceNumber);
    });
    test(
        'should received a DepositCheckEntity and return DepositCheckServiceRequestModel',
        () async {
      final requestModel = DepositCheckServiceAdapter().createRequest(tEntity);
      expect(requestModel.accountNumber, tRequestModel.accountNumber);
      expect(requestModel.depositAmount, tRequestModel.depositAmount);
      expect(requestModel.frontCheckImg, tRequestModel.frontCheckImg);
      expect(requestModel.backCheckImg, tRequestModel.backCheckImg);
    });
  });
}
