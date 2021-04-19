import 'package:clean_framework/clean_framework_defaults.dart';

class CheckDepositServiceResponseModel extends JsonResponseModel {
  final bool didSucceed;

  CheckDepositServiceResponseModel.fromJson(Map<String, dynamic> json)
      : didSucceed = true;

  @override
  List<Object> get props => [didSucceed];
}
