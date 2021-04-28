// @dart=2.9
import 'package:business_banking/features/deposit_check/api/account_info_response_model.dart';
import 'package:business_banking/features/deposit_check/api/account_info_service.dart';
import 'package:test/test.dart';

void main() {
  AccountInfoService service;

  // Registers a function to be run before tests. This function will be called before each test is run.
  setUp(() {
    service = AccountInfoService();
  });

  group('AccountInfo Service Test', () {
    final tJsonResponse = {
      "accountNumber": "1234567890126917",
      "availableBalance": 481.84,
      "depositLimit": 4500.00,
      "accountNickname": "Checking Account (...6917)"
    };

    test('should perform a GET request', () async {
      final eitherResponce = await service.request();

      expect(eitherResponce.isRight, isTrue);
    });

    test(
        'should InvestmentService return AccountInfoServiceResponseModel when the response is success',
        () async {
      final eitherResponce = await service.request();

      expect(eitherResponce.fold((_) {}, (m) => m),
          AccountInfoServiceResponseModel.fromJson(tJsonResponse));
    });
  });
}
