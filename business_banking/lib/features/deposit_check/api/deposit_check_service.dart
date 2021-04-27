import 'package:business_banking/features/deposit_check/api/deposit_check_response_model.dart';
import 'package:business_banking/features/deposit_check/api/deposit_check_request_model.dart';
import 'package:business_banking/locator.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework/clean_framework_defaults.dart';

class CheckDepositService extends EitherService<CheckDepositServiceRequestModel,
    CheckDepositServiceResponseModel> {
  CheckDepositService()
      : super(
            method: RestMethod.post,
            restApi: ExampleLocator().api,
            path: 'deposit-check');

  @override
  CheckDepositServiceResponseModel parseResponse(
      Map<String, dynamic> jsonResponse) {
    print('CheckDepositService -- parseResponse');
    return CheckDepositServiceResponseModel.fromJson(jsonResponse);
  }
}
