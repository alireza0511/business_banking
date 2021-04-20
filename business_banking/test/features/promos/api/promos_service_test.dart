import 'package:business_banking/features/promos/api/promos_service.dart';
import 'package:business_banking/features/promos/api/promos_service_request_model.dart';
import 'package:business_banking/features/promos/api/promos_service_response_model.dart';
import 'package:clean_framework/clean_framework_defaults.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('PromosService success', () async {
    final requestModel = PromosServiceRequestModel(customerId: "123");
    final service = PromosService();
    final eitherResponse = await service.request(requestModel: requestModel);

    expect(eitherResponse.isRight, isTrue);
    expect(
      eitherResponse.fold((_) {}, (m) => m),
      PromosServiceResponseModel.fromJson({
        'imageUrl': 'https://via.placeholder.com/300',
        'externalUrl': 'https://www.huntington.com/'
      }),
    );
  });

  test(
    'PromosService Error',
    () async {
      final requestModel = PromosServiceRequestModel(customerId: "143");
      final service = PromosService();
      final eitherResponse = await service.request(requestModel: requestModel);

      expect(eitherResponse.isLeft, isTrue);
      expect(
        eitherResponse.fold((e) {
          print(e);
          return e;
        }, (_) {}),
        isA<GeneralServiceFailure>(),
      );
    },
  );
}
