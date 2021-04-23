import 'package:business_banking/features/deposit_check/model/deposit_check_entity.dart';
import 'package:business_banking/features/deposit_check/model/deposit_check_view_model.dart';
import 'package:clean_framework/clean_framework.dart';

import '../../../locator.dart';
import 'account_info_service_adapter.dart';

class AccountInfoUseCase extends UseCase {
  late final ViewModelCallback<DepositCheckViewModel> _viewModelCallBack;

  AccountInfoUseCase(ViewModelCallback<DepositCheckViewModel> viewModelCallBack)
      : _viewModelCallBack = viewModelCallBack;

  void execute() async {
    final scope = ExampleLocator()
        .repository
        .create<DepositCheckEntity>(DepositCheckEntity(), _notifySubscribers);

    await ExampleLocator()
        .repository
        .runServiceAdapter(scope, AccountInfoServiceAdapter());
  }

  void _notifySubscribers(entity) {
    _viewModelCallBack(buildViewModel(entity));
  }

  DepositCheckViewModel buildViewModel(DepositCheckEntity entity) {
    return DepositCheckViewModel(
        accountInfo: entity.accountInfo,
        backCheckImg: '',
        depositAmount: '0.0',
        frontCheckImg: '',
        referenceNumber: '');
  }
}
