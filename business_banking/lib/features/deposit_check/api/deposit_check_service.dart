import 'package:business_banking/features/deposit_check/api/deposit_check_response_model.dart';
import 'package:business_banking/features/deposit_check/api/deposit_check_request_model.dart';
import 'package:business_banking/locator.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework/clean_framework_defaults.dart';

class DepositCheckService extends EitherService<DepositCheckServiceRequestModel,
    DepositCheckServiceResponseModel> {
  DepositCheckService()
      : super(
            method: RestMethod.post,
            restApi: ExampleLocator().api,
            path: 'deposit-check');

  @override
  DepositCheckServiceResponseModel parseResponse(
      Map<String, dynamic> jsonResponse) {
    return DepositCheckServiceResponseModel.fromJson(jsonResponse);
  }
}
