// @dart=2.9
import 'package:business_banking/dependency/Image_picker_plugin.dart';
import 'package:business_banking/dependency/permission_handler_plugin.dart';
import 'package:business_banking/features/deposit_check/bloc/2nd_data_entry/deposit_check_usecase.dart';
import 'package:business_banking/features/deposit_check/model/2nd_data_entry/deposit_check_view_model.dart';
import 'package:business_banking/features/deposit_check/model/account_info_struct.dart';
import 'package:business_banking/features/deposit_check/model/enums.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
//import 'package:test/test.dart';

import '../deposit_check_bloc_mock.dart';

class MockPermissionHandlerPlugin extends Mock
    implements PermissionHandlerPlugin {
  @override
  Future<bool> isGrantedAccessCamera() async {
    return true;
  }
}

class MockImagePickerPlugin extends Mock implements ImagePickerPlugin {
  @override
  Future<String> cameraImgFilePath() async {
    return 'image';
  }
}

void main() {
  DepositCheckUseCase useCase;

  DepositCheckViewModel depositCheckViewModel;

  setUp(() {
    useCase = DepositCheckUseCase((viewModel) {
      depositCheckViewModel = viewModel;
      return true;
    }, MockPermissionHandlerPlugin(), MockImagePickerPlugin());
  });

  group('Deposit Check Usecase', () {
    final tAccountInfo = AccountInfoStruct(
        accountNickname: 'Checking Account (...6917)',
        accountNumber: '1234567890126917',
        availableBalance: 481.84,
        depositLimit: 4500.0);

    test('should value receive from pipe be the same as source value',
        () async {
      await useCase.execute();

      expect(depositCheckViewModel, isNotNull);
    });

    test(
        'should updateAccountInfo method receive AccountInfo and update view Model',
        () async {
      useCase.updateAccountInfo(tAccountInfo);

      expect(depositCheckViewModel.accountInfo, tAccountInfo);
    });
    test('should updateAmount method receive Amount and update view Model',
        () async {
      useCase.updateAmount(200.0);

      expect(depositCheckViewModel.depositAmount, 200.0);
    });
    test(
        'should updateAmount method return 0.0 amount with a status and invalid UserInputStatus, if user insert negative Amount and update view Model',
        () async {
      useCase.updateAmount(-200.0);

      expect(depositCheckViewModel.depositAmount, 0.0);
      expect(depositCheckViewModel.userInputStatus, UserInputStatus.invalid);
      expect(depositCheckViewModel.depositAmountStatus,
          'Please, provide a valid amount.');
    });

    test('should updateEmail method receive Email and update view Model',
        () async {
      useCase.updateEmail('sample@hnb.com');

      expect(depositCheckViewModel.userEmail, 'sample@hnb.com');
    });
    test(
        'should updateEmail method return a status and invalid UserInputStatus, if user insert not valid Email address',
        () async {
      useCase.updateEmail('sample');

      expect(depositCheckViewModel.userInputStatus, UserInputStatus.invalid);
      expect(depositCheckViewModel.userEmailStatus,
          'Please, provide a valid email.');
    });

// ! Error: img retrun is null
    test('should updateImgs method receive Img and update view Model',
        () async {
      // TestWidgetsFlutterBinding.ensureInitialized();

      await useCase.updateImgs(CheckImageType.front);

      expect(depositCheckViewModel.frontCheckImg, isNotNull);
    });

//?  How should check this func?
    test('should ...', () async {
      useCase.submitDepositCheck();
    });
  });
}

//  test('should resetViewModel method reset view model', () async {
//       useCase.resetViewModel();

//       expect(depositCheckViewModel.depositAmount, 0.0);
//       expect(depositCheckViewModel.depositAmountStatus, '');
//       expect(depositCheckViewModel.userEmail, '');
//       expect(depositCheckViewModel.userEmailStatus, '');
//       expect(depositCheckViewModel.referenceNumber, '');
//       expect(depositCheckViewModel.userInputStatus, UserInputStatus.unknown);
//     });
