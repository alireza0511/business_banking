import 'package:business_banking/features/deposit_check/model/2nd_data_entry/deposit_check_entity.dart';
import 'package:business_banking/features/deposit_check/model/3rd_request_confirmation/deposit_check_confirm_view_model.dart';
import 'package:business_banking/features/deposit_check/model/enums.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework/clean_framework_defaults.dart';

import '../../../../locator.dart';

class DepositCheckConfirmUseCase extends UseCase {
  late final ViewModelCallback<DepositCheckConfirmViewModel> _viewModelCallBack;
  RepositoryScope? _scope;

  DepositCheckConfirmUseCase(
      ViewModelCallback<DepositCheckConfirmViewModel> viewModelCallBack)
      : _viewModelCallBack = viewModelCallBack;

  void execute() async {
    _scope = ExampleLocator().repository.containsScope<DepositCheckEntity>();

    if (_scope == null) {
      throw StateError('Deposit Check entity does not exist');
    }
    _scope!.subscription = _notifySubscribers;
    final entity = ExampleLocator().repository.get<DepositCheckEntity>(_scope!);
    _viewModelCallBack(buildViewModel(entity));
  }

  void _notifySubscribers(entity) {
    _viewModelCallBack(buildViewModel(entity));
  }

  void resetViewModel() {
    final entity = ExampleLocator().repository.get<DepositCheckEntity>(_scope!);
    final emptyEntity = DepositCheckEntity(accountInfo: entity.accountInfo);
    ExampleLocator()
        .repository
        .update<DepositCheckEntity>(_scope!, emptyEntity);
    _notifySubscribers(emptyEntity);
  }

  DepositCheckConfirmViewModel buildViewModel(DepositCheckEntity entity) {
    if (entity.hasErrors()) {
      return DepositCheckConfirmViewModel(
          accountInfo: entity.accountInfo!,
          backCheckImg: entity.backCheckImg,
          depositAmount: entity.depositAmount,
          frontCheckImg: entity.frontCheckImg,
          referenceNumber: entity.referenceNumber ?? '',
          serviceResponseStatus: ServiceResponseStatus.failed);
    } else {
      if (entity.referenceNumber!.isNotEmpty) {
        return DepositCheckConfirmViewModel(
            accountInfo: entity.accountInfo!,
            backCheckImg: entity.backCheckImg,
            depositAmount: entity.depositAmount,
            frontCheckImg: entity.frontCheckImg,
            referenceNumber: entity.referenceNumber ?? '',
            serviceResponseStatus: ServiceResponseStatus.succeed);
      } else {
        return DepositCheckConfirmViewModel(
            accountInfo: entity.accountInfo!,
            backCheckImg: entity.backCheckImg,
            depositAmount: entity.depositAmount,
            frontCheckImg: entity.frontCheckImg,
            referenceNumber: entity.referenceNumber ?? '',
            serviceResponseStatus: ServiceResponseStatus.failed);
      }
    }
  }
}
