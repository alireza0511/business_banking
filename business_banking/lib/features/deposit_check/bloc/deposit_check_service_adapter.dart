import 'package:business_banking/features/deposit_check/api/deposit_check_request_model.dart';
import 'package:business_banking/features/deposit_check/api/deposit_check_response_model.dart';
import 'package:business_banking/features/deposit_check/api/deposit_check_service.dart';
import 'package:business_banking/features/deposit_check/model/deposit_check_entity.dart';
import 'package:clean_framework/clean_framework.dart';

class DepositCheckServiceAdapter extends ServiceAdapter<
    DepositCheckEntity,
    CheckDepositServiceRequestModel,
    CheckDepositServiceResponseModel,
    CheckDepositService> {
  DepositCheckServiceAdapter() : super(CheckDepositService());

  @override
  createEntity(initialEntity, responseModel) {
    return initialEntity.merge(
        errors: <EntityFailure>[],
        referenceNumber: responseModel.referenceNumber);
  }

  @override
  CheckDepositServiceRequestModel createRequest(DepositCheckEntity entity) {
    return CheckDepositServiceRequestModel(
        accountNumber: entity.accountInfo!.accountNumber,
        depositAmount: entity.depositAmount,
        backCheckImg: entity.backCheckImg,
        frontCheckImg: entity.frontCheckImg);
  }
}
