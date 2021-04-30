// @dart = 2.9
import 'package:business_banking/core/Util/util.dart';
import 'package:business_banking/features/deposit_check/model/1st_hub_card/deposit_check_card_view_model.dart';
import 'package:business_banking/features/deposit_check/model/3rd_request_confirmation/deposit_check_confirm_view_model.dart';
import 'package:business_banking/features/deposit_check/model/account_info_struct.dart';
import 'package:business_banking/features/deposit_check/model/enums.dart';
import 'package:business_banking/features/deposit_check/ui/1st_hub_card/deposit_check_card_screen.dart';
import 'package:business_banking/features/deposit_check/ui/3rd_request_confirmation/deposit_check_confirm_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../test_util.dart';
import 'deposit_check_confirm_presenter_test.dart';

void main() {
  MaterialApp testWidgetSucceed;
  MaterialApp testWidgetFailed;
  DepositCheckConfirmViewModel depositCheckViewModelSucceed;
  DepositCheckConfirmViewModel depositCheckViewModelFailed;
  MockConfirmPressenterAction mockPressenterAction;

  setUp(() async {
    depositCheckViewModelSucceed = DepositCheckConfirmViewModel(
        accountInfo: AccountInfoStruct(
          accountNumber: '1234567890126917',
          availableBalance: 481.84,
          depositLimit: 4500.00,
          accountNickname: 'Checking Account (...6917)',
        ),
        depositAmount: 200.0,
        frontCheckImg: '',
        backCheckImg: '',
        referenceNumber: '#1',
        serviceResponseStatus: ServiceResponseStatus.succeed);

    depositCheckViewModelFailed = DepositCheckConfirmViewModel(
        accountInfo: AccountInfoStruct(
          accountNumber: '1234567890126917',
          availableBalance: 481.84,
          depositLimit: 4500.00,
          accountNickname: 'Checking Account (...6917)',
        ),
        depositAmount: 200.0,
        frontCheckImg: 'front',
        backCheckImg: 'back',
        referenceNumber: '',
        serviceResponseStatus: ServiceResponseStatus.failed);

    mockPressenterAction = MockConfirmPressenterAction();

    testWidgetSucceed = MaterialApp(
      home: DepositCheckConfirmScreen(
          viewModel: depositCheckViewModelSucceed,
          pressenterAction: mockPressenterAction),
    );

    testWidgetFailed = MaterialApp(
      home: DepositCheckConfirmScreen(
          viewModel: depositCheckViewModelFailed,
          pressenterAction: mockPressenterAction),
    );
  });

  tearDown(() {
    depositCheckViewModelSucceed = null;
    depositCheckViewModelFailed = null;
    mockPressenterAction = null;
  });
  group('Deposit Check Confirm', () {
    testWidgets('should shows the screen', (tester) async {
      await tester.pumpWidget(testWidgetSucceed);
      await tester.pump(Duration(milliseconds: 500));

      final widgetType = find.byType(DepositCheckConfirmScreen);
      expect(widgetType, findsOneWidget);
    });

    testWidgets(
        'should show account info and reference number on Deposit Check Confirm page with succeed response',
        (tester) async {
      await tester.pumpWidget(testWidgetSucceed);
      await tester.pump(Duration(milliseconds: 500));

      // Titel
      expect(find.text('CONFIRMATION'), findsOneWidget);
      // Account data
      expect(
          find.text(
              'Deposit to ${depositCheckViewModelSucceed.accountInfo.accountNickname}'),
          findsOneWidget);
      // Divider
      expect(find.byType(Divider), findsWidgets);

      expect(find.text('Front of Check'), findsOneWidget);
      expect(find.text('Back of Check'), findsOneWidget);
      expect(find.text('Deposit Amount'), findsOneWidget);
      expect(find.text('\$${depositCheckViewModelSucceed.depositAmount}'),
          findsOneWidget);
      expect(find.text('Reference Number'), findsOneWidget);
      expect(find.text('${depositCheckViewModelSucceed.referenceNumber}'),
          findsOneWidget);
      expect(
          find.text(
              '''Money from deposits may not be available for immediate withdrawal. Our general policy is to allow you to withdraw money deposited in your account no later than the first business day after the day we receive your deposit.'''),
          findsOneWidget);
    });
    testWidgets(
        'should show account info on Deposit Check Confirm page with failed response',
        (tester) async {
      await tester.pumpWidget(testWidgetFailed);
      await tester.pump(Duration(milliseconds: 500));

      // Titel
      expect(find.text('CONFIRMATION'), findsOneWidget);
      // Account data
      expect(
          find.text(
              'Deposit to ${depositCheckViewModelSucceed.accountInfo.accountNickname}'),
          findsOneWidget);
      // Divider
      expect(find.byType(Divider), findsOneWidget);

      expect(find.text('Deposit Amount'), findsOneWidget);
      expect(find.text('\$${depositCheckViewModelSucceed.depositAmount}'),
          findsOneWidget);
      expect(find.text('Please try again later!'), findsOneWidget);
    });

    testWidgets('should call navigate to Back page on presenter action',
        (tester) async {
      await tester.pumpWidget(testWidgetSucceed);
      await tester.pump(Duration(milliseconds: 500));

      var widget = find.byKey(Key('Deposit-Check-Confirm-Close-Button'));
      expect(widget, findsOneWidget);
      await tester.tap(widget);
      verify(mockPressenterAction.popNavigationListener(any)).called(1);
    });
  });
}
