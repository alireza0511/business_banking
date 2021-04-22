import 'package:business_banking/features/deposit_check/bloc/deposit_check_service_adapter.dart';
import 'package:business_banking/features/deposit_check/model/account_info_entity.dart';
import 'package:business_banking/features/deposit_check/model/account_info_view_model.dart';
import 'package:clean_framework/clean_framework.dart';

import '../../../locator.dart';
import 'account_info_service_adapter.dart';

/// UseCase is a declarative chain of pure functions (instruction or command).
/// Commands are async functions that return an Either or Maybe.
/// The commands will receive the state and create new states.
///   a) Developers cannot change state when it is not allowed.
///   b) History of changes.
/// Bloc events will launch UseCases, while listening to publications from the UseCase that
///   returns a ViewModel, which is pushed down to the Presenter.

class AccountInfoUseCase extends UseCase {
  late final ViewModelCallback<AccountInfoViewModel> _viewModelCallBack;

  AccountInfoUseCase(ViewModelCallback<AccountInfoViewModel> viewModelCallBack)
      : _viewModelCallBack = viewModelCallBack;

  void execute() async {
    final scope = ExampleLocator()
        .repository
        .create<AccountInfoEntity>(AccountInfoEntity(), _notifySubscribers);

    await ExampleLocator()
        .repository
        .runServiceAdapter(scope, AccountInfoServiceAdapter());
  }

  void _notifySubscribers(entity) {
    _viewModelCallBack(buildViewModel(entity));
  }

  AccountInfoViewModel buildViewModel(AccountInfoEntity entity) {
    return AccountInfoViewModel(
        accountNumber: entity.accountNumber,
        accountNickname: entity.accountNickname,
        depositLimit: entity.depositLimit,
        availableBalance: entity.availableBalance);
  }
}
