import 'package:clean_framework/clean_framework_defaults.dart';

class CheckDepositServiceResponseModel extends JsonResponseModel {
  final bool didSucceed;
  final String status;
  final String referenceNumber;

  CheckDepositServiceResponseModel.fromJson(Map<String, dynamic> json)
      : didSucceed = json['didSucceed'] ?? false,
        status = json['status'] ?? '',
        referenceNumber = json['referenceNumber'] ?? '';

  @override
  List<Object> get props => [didSucceed, status, referenceNumber];
}
