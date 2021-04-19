import 'package:business_banking/features/check_deposit/api/account_info_response_model.dart';
import 'package:business_banking/locator.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework/clean_framework_defaults.dart';

class AccountInfoService
    extends EitherService<JsonRequestModel, AccountInfoServiceResponseModel> {
  AccountInfoService()
      : super(
            method: RestMethod.get,
            restApi: ExampleLocator().api,
            path: 'account-info');

  @override
  AccountInfoServiceResponseModel parseResponse(
      Map<String, dynamic> jsonResponse) {
    return AccountInfoServiceResponseModel.fromJson(jsonResponse);
  }
}
