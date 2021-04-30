import 'package:business_banking/dependency/Image_picker_plugin.dart';
import 'package:business_banking/dependency/permission_handler_plugin.dart';
import 'package:business_banking/features/deposit_check/model/2nd_data_entry/deposit_check_entity.dart';
import 'package:business_banking/features/deposit_check/model/2nd_data_entry/deposit_check_view_model.dart';
import 'package:business_banking/features/deposit_check/model/account_info_struct.dart';
import 'package:business_banking/features/deposit_check/model/enums.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework/clean_framework_defaults.dart';

import '../../../../locator.dart';
import 'deposit_check_service_adapter.dart';

class DepositCheckUseCase extends UseCase {
  late final ViewModelCallback<DepositCheckViewModel> _viewModelCallBack;
  late final PermissionHandlerPlugin _permissionHandlerPluginImpl;
  late final ImagePickerPlugin _imagePickerPluginImpl;

  RepositoryScope? _scope;

  DepositCheckUseCase(
      ViewModelCallback<DepositCheckViewModel> viewModelCallBack,
      PermissionHandlerPlugin permissionHandlerPlugin,
      ImagePickerPlugin imagePickerPlugin)
      : _viewModelCallBack = viewModelCallBack,
        _permissionHandlerPluginImpl = permissionHandlerPlugin,
        _imagePickerPluginImpl = imagePickerPlugin;

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
    _viewModelCallBack(buildViewModel(entity, isResetAction: true));
  }

  DepositCheckViewModel buildViewModel(DepositCheckEntity entity,
      {String status = '',
      isUserInputValid = true,
      inputStatusType = InputStatusType.unknown,
      isResetAction = false}) {
    if (entity.hasErrors()) {
      return DepositCheckViewModel(
          accountInfo: entity.accountInfo,
          frontCheckImg: entity.frontCheckImg,
          backCheckImg: entity.backCheckImg,
          depositAmount: entity.depositAmount,
          referenceNumber: entity.referenceNumber!,
          userEmail: entity.userEmail,
          depositAmountStatus:
              inputStatusType == InputStatusType.depositAmount ? status : '',
          userEmailStatus:
              inputStatusType == InputStatusType.userEmail ? status : '',
          userInputStatus: isUserInputValid
              ? _checkUserInputEntity(entity)
              : UserInputStatus.invalid,
          serviceResponseStatus: ServiceResponseStatus.failed);
    } else {
      return DepositCheckViewModel(
          accountInfo: entity.accountInfo,
          frontCheckImg: entity.frontCheckImg,
          backCheckImg: entity.backCheckImg,
          depositAmount: entity.depositAmount,
          referenceNumber: entity.referenceNumber!,
          userEmail: entity.userEmail,
          depositAmountStatus:
              inputStatusType == InputStatusType.depositAmount ? status : '',
          userEmailStatus:
              inputStatusType == InputStatusType.userEmail ? status : '',
          userInputStatus: isResetAction
              ? UserInputStatus.unknown
              : (isUserInputValid
                  ? _checkUserInputEntity(entity)
                  : UserInputStatus.invalid),
          serviceResponseStatus: isResetAction
              ? ServiceResponseStatus.unknown
              : ServiceResponseStatus.succeed);
    }
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
    _viewModelCallBack(buildViewModel(updatedEntity, isResetAction: true));
  }

  void updateAmount(double amount) {
    if (_scope == null) {
      _scope = ExampleLocator().repository.create<DepositCheckEntity>(
          new DepositCheckEntity(), _notifySubscribers);
    }
    final entity = ExampleLocator().repository.get<DepositCheckEntity>(_scope!);

    if (amount > 0) {
      final updatedEntity = entity.merge(depositAmount: amount);
      ExampleLocator()
          .repository
          .update<DepositCheckEntity>(_scope!, updatedEntity);
      _viewModelCallBack(buildViewModel(updatedEntity,
          status: '',
          inputStatusType: InputStatusType.depositAmount,
          isUserInputValid: true));
    } else {
      final updatedEntity = entity.merge(depositAmount: 0.0);
      ExampleLocator()
          .repository
          .update<DepositCheckEntity>(_scope!, updatedEntity);
      _viewModelCallBack(buildViewModel(updatedEntity,
          status: 'Please, provide a valid amount.',
          inputStatusType: InputStatusType.depositAmount,
          isUserInputValid: false));
    }
  }

  void updateEmail(String email) {
    if (_scope == null) {
      _scope = ExampleLocator().repository.create<DepositCheckEntity>(
          new DepositCheckEntity(), _notifySubscribers);
    }

    final entity = ExampleLocator().repository.get<DepositCheckEntity>(_scope!);

    if (email.contains(RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")) ==
        true) {
      final updatedEntity = entity.merge(userEmail: email);
      ExampleLocator()
          .repository
          .update<DepositCheckEntity>(_scope!, updatedEntity);
      _viewModelCallBack(buildViewModel(updatedEntity,
              status: '',
              inputStatusType: InputStatusType.userEmail,
              isUserInputValid: true)
          // buildViewModelUpdateEmailStatus(updatedEntity)
          );
    } else {
      final updatedEntity = entity.merge(userEmail: email);
      ExampleLocator()
          .repository
          .update<DepositCheckEntity>(_scope!, updatedEntity);
      _viewModelCallBack(buildViewModel(updatedEntity,
              status: 'Please, provide a valid email.',
              inputStatusType: InputStatusType.userEmail,
              isUserInputValid: false)
          // buildViewModelUpdateEmailStatus(updatedEntity,
          //   status: 'Please, provide a valid email.', isUserInputValid: false)
          );
    }
  }

  void updateImgs(CheckImageType imgType) async {
    if (_scope == null) {
      _scope = ExampleLocator().repository.create<DepositCheckEntity>(
          new DepositCheckEntity(), _notifySubscribers);
    }
    String imgFilePath = '';

    var isGranted = await _permissionHandlerPluginImpl.isGrantedAccessCamera();
    if (isGranted == true) {
      imgFilePath = await _imagePickerPluginImpl.cameraImgFilePath();
    }

    final entity = ExampleLocator().repository.get<DepositCheckEntity>(_scope!);

    if (imgFilePath.isNotEmpty) {
      final updatedEntity = imgType == CheckImageType.front
          ? entity.merge(frontCheckImg: imgFilePath)
          : entity.merge(backCheckImg: imgFilePath);

      ExampleLocator()
          .repository
          .update<DepositCheckEntity>(_scope!, updatedEntity);

      _viewModelCallBack(buildViewModel(
        updatedEntity,
        isUserInputValid: true,
        status: '',
        inputStatusType: imgType == CheckImageType.front
            ? InputStatusType.checkFrontImg
            : InputStatusType.checkBackImg,
      ));
    } else {
      _viewModelCallBack(buildViewModel(
        entity,
        isUserInputValid: false,
        status: 'Please, provide requiered images.',
        inputStatusType: imgType == CheckImageType.front
            ? InputStatusType.checkFrontImg
            : InputStatusType.checkBackImg,
      ));
    }
  }

  Future<void> submitDepositCheck() async {
    if (_scope == null) {
      _scope = ExampleLocator().repository.create<DepositCheckEntity>(
          new DepositCheckEntity(), _notifySubscribers);
    }
    final entity = ExampleLocator().repository.get<DepositCheckEntity>(_scope!);
    if (_checkUserInputEntity(entity) == UserInputStatus.valid) {
      await ExampleLocator()
          .repository
          .runServiceAdapter(_scope!, DepositCheckServiceAdapter());
    } else {
      _viewModelCallBack(buildViewModel(entity, isUserInputValid: true)
          //buildViewModelForLocalUpdate(entity)
          );
    }
  }

  UserInputStatus _checkUserInputEntity(DepositCheckEntity entity) {
    if (entity.frontCheckImg.isNotEmpty &&
        entity.backCheckImg.isNotEmpty &&
        entity.depositAmount > 0 &&
        entity.userEmail.isNotEmpty) {
      return UserInputStatus.valid;
    }
    return UserInputStatus.invalid;
  }
}

/*

  DepositCheckViewModel b1uildViewModelUpdateDepositAmountStatus(
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

  DepositCheckViewModel b1uildViewModelForLocalUpdate(
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

  DepositCheckViewModel b1uildViewModelForLocalUpdateWithResetServiceStatus(
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
 
   DepositCheckViewModel b1uildViewModelUpdateEmailStatus(
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
 */
// void resetServiceStatus() {
//   if (_scope == null) {
//     _scope = ExampleLocator().repository.create<DepositCheckEntity>(
//         new DepositCheckEntity(), _notifySubscribers);
//   }
//   final entity = ExampleLocator().repository.get<DepositCheckEntity>(_scope!);
//   _viewModelCallBack(
//       buildViewModelForLocalUpdateWithResetServiceStatus(entity));
// }

//  DepositCheckViewModel buildViewModelOld(DepositCheckEntity entity) {
//     return DepositCheckViewModel(
//         accountInfo: entity.accountInfo,
//         frontCheckImg: entity.frontCheckImg,
//         backCheckImg: entity.backCheckImg,
//         depositAmount: entity.depositAmount,
//         referenceNumber: entity.referenceNumber!,
//         userEmail: entity.userEmail);
//   }
//
