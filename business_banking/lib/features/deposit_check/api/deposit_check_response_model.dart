import 'package:clean_framework/clean_framework_defaults.dart';

class DepositCheckServiceResponseModel extends JsonResponseModel {
  final bool didSucceed;
  final String status;
  final String referenceNumber;

  DepositCheckServiceResponseModel.fromJson(Map<String, dynamic> json)
      : didSucceed = json['didSucceed'] ?? false,
        status = json['status'] ?? '',
        referenceNumber = json['referenceNumber'] ?? '';

  @override
  List<Object> get props => [didSucceed, status, referenceNumber];
}
