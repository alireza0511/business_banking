import 'package:business_banking/features/deposit_check/model/deposit_check_card_entity.dart';
import 'package:business_banking/features/deposit_check/model/deposit_check_card_view_model.dart';
import 'package:business_banking/features/deposit_check/model/deposit_check_entity.dart';
import 'package:business_banking/features/deposit_check/model/deposit_check_view_model.dart';
import 'package:business_banking/features/deposit_check/model/enums.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework/clean_framework_defaults.dart';

import '../../../locator.dart';
import 'account_info_service_adapter.dart';

class DepositCheckCardUseCase extends UseCase {
  late final ViewModelCallback<DepositCheckCardViewModel> _viewModelCallBack;
  RepositoryScope? _scope;

  DepositCheckCardUseCase(
      ViewModelCallback<DepositCheckCardViewModel> viewModelCallBack)
      : _viewModelCallBack = viewModelCallBack;

  void execute() async {
    _scope =
        ExampleLocator().repository.containsScope<DepositCheckCardEntity>();
    if (_scope == null) {
      _scope = ExampleLocator().repository.create<DepositCheckCardEntity>(
          new DepositCheckCardEntity(), _notifySubscribers);

      await ExampleLocator()
          .repository
          .runServiceAdapter(_scope!, AccountInfoServiceAdapter());
    } else {
      _scope!.subscription = _notifySubscribers;
    }
  }

  void _notifySubscribers(entity) {
    _viewModelCallBack(buildViewModel(entity));
  }

  DepositCheckCardViewModel buildViewModel(DepositCheckCardEntity entity) {
    if (entity.hasErrors()) {
      return DepositCheckCardViewModel(
        accountInfo: entity.accountInfo,
        serviceResponseStatus: ServiceResponseStatus.failed,
      );
    } else {
      return DepositCheckCardViewModel(
        accountInfo: entity.accountInfo,
        serviceResponseStatus: ServiceResponseStatus.succeed,
      );
    }
  }
}
