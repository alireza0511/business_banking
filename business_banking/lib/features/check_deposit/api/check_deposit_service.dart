import 'package:business_banking/features/check_deposit/api/check_deposit_response_model.dart';
import 'package:business_banking/features/check_deposit/api/check_deposit_request_model.dart';
import 'package:business_banking/locator.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework/clean_framework_defaults.dart';

class CheckDepositService extends EitherService<CheckDepositServiceRequestModel,
    CheckDepositServiceResponseModel> {
  CheckDepositService()
      : super(
            method: RestMethod.post,
            restApi: ExampleLocator().api,
            path: 'check-deposit');

  @override
  CheckDepositServiceResponseModel parseResponse(
      Map<String, dynamic> jsonResponse) {
    return CheckDepositServiceResponseModel.fromJson(jsonResponse);
  }
}
