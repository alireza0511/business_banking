import 'package:business_banking/features/deposit_check/bloc/deposit_check_service_adapter.dart';
import 'package:business_banking/features/deposit_check/model/deposit_check_entity.dart';
import 'package:business_banking/features/deposit_check/model/deposit_check_view_model.dart';
import 'package:clean_framework/clean_framework.dart';

import '../../../locator.dart';

/// UseCase is a declarative chain of pure functions (instruction or command).
/// Commands are async functions that return an Either or Maybe.
/// The commands will receive the state and create new states.
///   a) Developers cannot change state when it is not allowed.
///   b) History of changes.
/// Bloc events will launch UseCases, while listening to publications from the UseCase that
///   returns a ViewModel, which is pushed down to the Presenter.

class DepositCheckUseCase extends UseCase {
  late final ViewModelCallback<DepositCheckViewModel> _viewModelCallBack;

  DepositCheckUseCase(
      ViewModelCallback<DepositCheckViewModel> viewModelCallBack)
      : _viewModelCallBack = viewModelCallBack;

  void execute() async {
    final scope = ExampleLocator()
        .repository
        .create<DepositCheckEntity>(DepositCheckEntity(), _notifySubscribers);

    await ExampleLocator()
        .repository
        .runServiceAdapter(scope, DepositCheckServiceAdapter());
  }

  void _notifySubscribers(entity) {
    _viewModelCallBack(buildViewModel(entity));
  }

  DepositCheckViewModel buildViewModel(DepositCheckEntity entity) {
    return DepositCheckViewModel(
        accountNumber: entity.accountNumber,
        frontCheckImg: entity.frontCheckImg,
        backCheckImg: entity.backCheckImg,
        depositAmount: entity.depositAmount);
  }
}
