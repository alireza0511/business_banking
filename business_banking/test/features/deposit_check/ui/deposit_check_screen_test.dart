// @dart = 2.9
import 'package:business_banking/features/deposit_check/model/account_info_struct.dart';
import 'package:business_banking/features/deposit_check/model/deposit_check_view_model.dart';
import 'package:business_banking/features/deposit_check/ui/request/deposit_check_presenter.dart';
import 'package:business_banking/features/deposit_check/ui/request/deposit_check_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockPressenterAction extends Mock
    implements DepositCheckPressenterActions {}

void main() {
  MaterialApp testWidget;
  DepositCheckViewModel depositCheckViewModel;
  MockPressenterAction mockPressenterAction;

  setUp(() {
    depositCheckViewModel = DepositCheckViewModel(
        accountInfo: AccountInfoStruct(
            accountNumber: '1234567890126917',
            availableBalance: 481.84,
            depositLimit: 4500.00,
            accountNickname: 'Checking Account (...6917)'),
        depositAmount: 0.0,
        frontCheckImg: '',
        backCheckImg: '',
        referenceNumber: '',
        userEmail: '');

    mockPressenterAction = MockPressenterAction();
    testWidget = MaterialApp(
      home: DepositCheckScreen(
          viewModel: depositCheckViewModel,
          pressenterAction: mockPressenterAction),
    );
  });

  tearDown(() {
    testWidget = null;
    mockPressenterAction = null;
    depositCheckViewModel = null;
  });
  group('Deposit Check Page', () {
    testWidgets('should shows the screen', (tester) async {
      await tester.pumpWidget(testWidget);
      await tester.pump(Duration(milliseconds: 500));

      final widgetType = find.byType(DepositCheckScreen);
      expect(widgetType, findsOneWidget);
    });

    testWidgets('should show Deposit Checks Item detail', (tester) async {
      await tester.pumpWidget(testWidget);
      await tester.pump(Duration(milliseconds: 500));

      // Titel
      // expect(find.text('Deposit to ${accountInfoViewModel.accountNickname}'),
      //     findsOneWidget);
      // img picker title
      expect(find.text('Front of Check'), findsOneWidget);
      expect(find.text('Back of Check'), findsOneWidget);

      // camera icon
      expect(find.byIcon(Icons.camera_alt), findsWidgets);
      // Deposit Limit
      expect(
          find.text(
              '''Deposit by 11 PM ET and your money will typical be available for withdrawl by next business day.'''),
          findsOneWidget);
    });

    testWidgets('should navigate to Back page', (tester) async {
      await tester.pumpWidget(testWidget);
      await tester.pump(Duration(milliseconds: 500));

      var widget = find.byKey(Key('Deposit-Check-Back-Button'));
      expect(widget, findsOneWidget);
      await tester.tap(widget);
      verify(mockPressenterAction.popNavigationListener(any)).called(1);
    });

    testWidgets(
        'should show textFields, button and when user enter value'
        ' It should findable', (tester) async {
      await tester.pumpWidget(testWidget);

      var amountTxtfildWidget = find.byKey(Key('Deposit-Check-Amount-Txtfild'));
      expect(amountTxtfildWidget, findsOneWidget);
      await tester.enterText(amountTxtfildWidget, '200.00');

      var emailTxtfildWidget = find.byKey(Key('Deposit-Check-Email-Txtfild'));
      expect(emailTxtfildWidget, findsOneWidget);
      await tester.enterText(emailTxtfildWidget, 'sample@hnb.com');

      var confirmBtnWidget = find.byKey(Key('Deposit-Check-Confirm-Button'));

      await tester.tap(confirmBtnWidget);
      await tester.pump(Duration(milliseconds: 500));

      await tester.pumpAndSettle();
      expect(find.text('sample@hnb.com'), findsOneWidget);
      expect(find.text('200.00'), findsOneWidget);
    });

    // testWidgets(
    //     'should show error when user tap confirm button'
    //     ' without validation.', (tester) async {
    //   await tester.pumpWidget(testWidget);

    //   var emailTxtfildWidget = find.byKey(Key('Deposit-Check-Email-Txtfild'));
    //   await tester.enterText(emailTxtfildWidget, 'sample');

    //   var confirmBtnWidget = find.byKey(Key('Deposit-Check-Confirm-Button'));

    //   await tester.tap(confirmBtnWidget, warnIfMissed: false);
    //   await tester.pump(Duration(milliseconds: 500));

    //   await tester.pumpAndSettle();
    //   expect(find.text('Please, provide a valid email.'), findsOneWidget);
    //   expect(find.text('Please provide a value.'), findsOneWidget);
    // });
  });
}
