// @dart=2.9
import 'package:business_banking/features/deposit_check/api/account_info_response_model.dart';
import 'package:business_banking/features/deposit_check/api/account_info_service.dart';
import 'package:business_banking/features/deposit_check/api/deposit_check_request_model.dart';
import 'package:business_banking/features/deposit_check/api/deposit_check_response_model.dart';
import 'package:business_banking/features/deposit_check/api/deposit_check_service.dart';
import 'package:test/test.dart';

void main() {
  DepositCheckService service;

  // Registers a function to be run before tests. This function will be called before each test is run.
  setUp(() {
    service = DepositCheckService();
  });

  group('DepositCheck Service Test', () {
    final tJsonResponse = {
      "status": "Successful",
      "didSucceed": true,
      "referenceNumber": "123456789"
    };

    test('should perform a POST request', () async {
      final eitherResponce = await service.request();

      expect(eitherResponce.isRight, isTrue);
    });

    test(
        'should return DepositCheckServiceResponseModel when the response is success',
        () async {
      final eitherResponce = await service.request(
          requestModel: DepositCheckServiceRequestModel(
        accountNumber: '123',
        depositAmount: 100,
        frontCheckImg: '',
        backCheckImg: '',
      ));

      expect(eitherResponce.fold((_) {}, (m) => m),
          DepositCheckServiceResponseModel.fromJson(tJsonResponse));
    });
  });
}
