import 'package:business_banking/dependency/Image_picker_plugin.dart';
import 'package:business_banking/dependency/permission_handler_plugin.dart';
import 'package:business_banking/features/deposit_check/model/account_info_struct.dart';
import 'package:business_banking/features/deposit_check/model/deposit_check_entity.dart';
import 'package:business_banking/features/deposit_check/model/deposit_check_view_model.dart';
import 'package:business_banking/features/deposit_check/model/enums.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework/clean_framework_defaults.dart';

import '../../../../locator.dart';
import 'deposit_check_service_adapter.dart';

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
      _scope = ExampleLocator().repository.create<DepositCheckEntity>(
          new DepositCheckEntity(), _notifySubscribers);
    } else {
      _scope!.subscription = _notifySubscribers;
    }

    final entity = ExampleLocator().repository.get<DepositCheckEntity>(_scope!);
    // if (entity.accountInfo == null) {
    //   // await ExampleLocator()
    //   //     .repository
    //   //     .runServiceAdapter(_scope!, AccountInfoServiceAdapter());
    //   _notifySubscribers(entity);
    // } else {
    _notifySubscribers(entity);
    // }
  }

  void _notifySubscribers(entity) {
    _viewModelCallBack(buildViewModel(entity));
  }

  DepositCheckViewModel buildViewModel(DepositCheckEntity entity) {
    return DepositCheckViewModel(
        accountInfo: entity.accountInfo,
        frontCheckImg: entity.frontCheckImg,
        backCheckImg: entity.backCheckImg,
        depositAmount: entity.depositAmount,
        referenceNumber: entity.referenceNumber!,
        userEmail: entity.userEmail);
  }

  void updateAccountInfo(AccountInfoStruct accountInfo) {
    if (_scope == null) {
      _scope = ExampleLocator().repository.create<DepositCheckEntity>(
          new DepositCheckEntity(), _notifySubscribers);
    }
    final entity = ExampleLocator().repository.get<DepositCheckEntity>(_scope!);

    final updatedEntity = entity.merge(accountInfo: accountInfo);
    ExampleLocator()
        .repository
        .update<DepositCheckEntity>(_scope!, updatedEntity);
    _viewModelCallBack(buildViewModel(updatedEntity));
  }

  void updateAmount(double amount) {
    final entity = ExampleLocator().repository.get<DepositCheckEntity>(_scope!);

    if (amount > 0) {
      final updatedEntity = entity.merge(depositAmount: amount);
      ExampleLocator()
          .repository
          .update<DepositCheckEntity>(_scope!, updatedEntity);
      _viewModelCallBack(
          buildViewModelUpdateDepositAmountStatus(updatedEntity));
    } else {
      final updatedEntity = entity.merge(depositAmount: amount);
      ExampleLocator()
          .repository
          .update<DepositCheckEntity>(_scope!, updatedEntity);
      _viewModelCallBack(buildViewModelUpdateDepositAmountStatus(updatedEntity,
          status:
              'Some msg related to Deposit amount should be bigger than 0'));
    }
  }

  void updateEmail(String email) {
    final entity = ExampleLocator().repository.get<DepositCheckEntity>(_scope!);
    if (email.contains(RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")) ==
        true) {
      final updatedEntity = entity.merge(userEmail: email);
      ExampleLocator()
          .repository
          .update<DepositCheckEntity>(_scope!, updatedEntity);
      _viewModelCallBack(buildViewModelUpdateEmailStatus(updatedEntity));
    } else {
      final updatedEntity = entity.merge(userEmail: email);
      ExampleLocator()
          .repository
          .update<DepositCheckEntity>(_scope!, updatedEntity);
      _viewModelCallBack(buildViewModelUpdateEmailStatus(updatedEntity,
          status: 'Please, provide a valid email.', isUserInputValid: false));
    }
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

  // Future<void> confirmDepositCheck0() async {
  //   await ExampleLocator()
  //       .repository
  //       .runServiceAdapter(_scope!, DepositCheckServiceAdapter());
  // }

  Future<void> submitDepositCheck() async {
    final entity = ExampleLocator().repository.get<DepositCheckEntity>(_scope!);
    if (_checkUserInputEntity(entity) == UserInputStatus.valid) {
      await ExampleLocator()
          .repository
          .runServiceAdapter(_scope!, DepositCheckServiceAdapter());
    } else {
      _viewModelCallBack(buildViewModelForLocalUpdate(entity));
    }
  }

  void resetServiceStatus() {
    final entity = ExampleLocator().repository.get<DepositCheckEntity>(_scope!);
    _viewModelCallBack(
        buildViewModelForLocalUpdateWithResetServiceStatus(entity));
  }

  void resetViewModel() {
    final entity = ExampleLocator().repository.get<DepositCheckEntity>(_scope!);
    final emptyEntity = DepositCheckEntity(accountInfo: entity.accountInfo);
    ExampleLocator()
        .repository
        .update<DepositCheckEntity>(_scope!, emptyEntity);
  }

  DepositCheckViewModel buildViewModelUpdateEmailStatus(
      DepositCheckEntity entity,
      {String status = '',
      isUserInputValid = true}) {
    return DepositCheckViewModel(
        accountInfo: entity.accountInfo,
        frontCheckImg: entity.frontCheckImg,
        backCheckImg: entity.backCheckImg,
        depositAmount: entity.depositAmount,
        referenceNumber: entity.referenceNumber!,
        userEmail: entity.userEmail,
        userEmailStatus: status,
        userInputStatus: isUserInputValid
            ? _checkUserInputEntity(entity)
            : UserInputStatus.invalid);
  }

  DepositCheckViewModel buildViewModelUpdateDepositAmountStatus(
      DepositCheckEntity entity,
      {String status = ''}) {
    return DepositCheckViewModel(
        accountInfo: entity.accountInfo,
        frontCheckImg: entity.frontCheckImg,
        backCheckImg: entity.backCheckImg,
        depositAmount: entity.depositAmount,
        referenceNumber: entity.referenceNumber!,
        userEmail: entity.userEmail,
        depositAmountStatus: status,
        userInputStatus: _checkUserInputEntity(entity));
  }

  DepositCheckViewModel buildViewModelForLocalUpdate(
      DepositCheckEntity entity) {
    if (entity.hasErrors()) {
      return DepositCheckViewModel(
          accountInfo: entity.accountInfo,
          frontCheckImg: entity.frontCheckImg,
          backCheckImg: entity.backCheckImg,
          depositAmount: entity.depositAmount,
          referenceNumber: entity.referenceNumber!,
          userEmail: entity.userEmail,
          userInputStatus: _checkUserInputEntity(entity),
          serviceResponseStatus: ServiceResponseStatus.failed);
    } else {
      return DepositCheckViewModel(
          accountInfo: entity.accountInfo,
          frontCheckImg: entity.frontCheckImg,
          backCheckImg: entity.backCheckImg,
          depositAmount: entity.depositAmount,
          referenceNumber: entity.referenceNumber!,
          userEmail: entity.userEmail,
          userInputStatus: _checkUserInputEntity(entity),
          serviceResponseStatus: ServiceResponseStatus.succeed);
    }
  }

  DepositCheckViewModel buildViewModelForLocalUpdateWithResetServiceStatus(
      DepositCheckEntity entity) {
    return DepositCheckViewModel(
        accountInfo: entity.accountInfo,
        frontCheckImg: entity.frontCheckImg,
        backCheckImg: entity.backCheckImg,
        depositAmount: entity.depositAmount,
        referenceNumber: entity.referenceNumber!,
        userEmail: entity.userEmail,
        serviceResponseStatus: ServiceResponseStatus.unknown,
        userInputStatus: _checkUserInputEntity(entity));
  }

  UserInputStatus _checkUserInputEntity(DepositCheckEntity entity) {
    if (
        //entity.frontCheckImg.isNotEmpty &&
        //  entity.backCheckImg.isNotEmpty &&
        entity.depositAmount > 0 && entity.userEmail.isNotEmpty) {
      return UserInputStatus.valid;
    }
    return UserInputStatus.invalid;
  }
}
