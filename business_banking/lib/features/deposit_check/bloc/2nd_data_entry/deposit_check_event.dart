import 'package:business_banking/features/deposit_check/model/enums.dart';
import 'package:equatable/equatable.dart';

abstract class DepositCheckEvent extends Equatable {}

class UpdateCheckAmountEvent implements DepositCheckEvent {
  final double checkAmount;

  UpdateCheckAmountEvent(this.checkAmount);

  @override
  List<Object> get props => [checkAmount];

  @override
  bool get stringify => true;
}

class UpdateUserEmailEvent implements DepositCheckEvent {
  final String userEmail;

  UpdateUserEmailEvent(this.userEmail);

  @override
  List<Object> get props => [userEmail];

  @override
  bool get stringify => true;
}

class UpdateCheckImgEvent implements DepositCheckEvent {
  final CheckImageType imgType;

  UpdateCheckImgEvent(this.imgType);

  @override
  List<Object> get props => [imgType];

  @override
  bool get stringify => true;
}

class SubmitDepositCheckEvent implements DepositCheckEvent {
  SubmitDepositCheckEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}
