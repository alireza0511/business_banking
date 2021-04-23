import 'dart:typed_data';

import 'package:business_banking/dependency/Image_picker_plugin.dart';
import 'package:business_banking/dependency/permission_handler_plugin.dart';
import 'package:business_banking/features/deposit_check/bloc/deposit_check_service_adapter.dart';
import 'package:business_banking/features/deposit_check/model/deposit_check_entity.dart';
import 'package:business_banking/features/deposit_check/model/deposit_check_view_model.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework/clean_framework_defaults.dart';

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
  late final PermissionHandlerPlugin _permissionHandlerPluginImpl =
      PermissionHandlerPlugin();
  late final ImagePickerPlugin _imagePickerPluginImpl = ImagePickerPlugin();

  RepositoryScope? _scope;
  DepositCheckUseCase(
      ViewModelCallback<DepositCheckViewModel> viewModelCallBack)
      : _viewModelCallBack = viewModelCallBack;

  void execute() async {
    _scope = ExampleLocator().repository.containsScope<DepositCheckEntity>();
    if (_scope == null) {
      _scope = ExampleLocator()
          .repository
          .create<DepositCheckEntity>(DepositCheckEntity(), _notifySubscribers);
    } else {
      _scope!.subscription = _notifySubscribers;
    }

    await ExampleLocator()
        .repository
        .runServiceAdapter(_scope!, DepositCheckServiceAdapter());
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

  void updateAmount(String amount) {
    final entity = ExampleLocator().repository.get<DepositCheckEntity>(_scope!);
    final updatedEntity = entity.merge(depositAmount: amount);
    ExampleLocator()
        .repository
        .update<DepositCheckEntity>(_scope!, updatedEntity);
    _viewModelCallBack(buildViewModelU(updatedEntity));
  }

  void updateImgs(String imgType) async {
    String img = '';
    var isGranted = await _permissionHandlerPluginImpl.isGrantedAccessCamera();
    if (isGranted == true) {
      img = await _imagePickerPluginImpl.cameraImgBase64();
    }

    final entity = ExampleLocator().repository.get<DepositCheckEntity>(_scope!);
    final updatedEntity = imgType == 'front'
        ? entity.merge(frontCheckImg: img)
        : entity.merge(backCheckImg: img);
    ExampleLocator()
        .repository
        .update<DepositCheckEntity>(_scope!, updatedEntity);
    _viewModelCallBack(buildViewModel(updatedEntity));
  }

  DepositCheckViewModel buildViewModelU(DepositCheckEntity entity) {
    return DepositCheckViewModel(
        accountNumber: entity.accountNumber,
        frontCheckImg: entity.frontCheckImg,
        backCheckImg: entity.backCheckImg,
        depositAmount: entity.depositAmount);
  }

  Future<void> confirmDepositCheck() async {
    await ExampleLocator()
        .repository
        .runServiceAdapter(_scope!, DepositCheckServiceAdapter());
  }
}
