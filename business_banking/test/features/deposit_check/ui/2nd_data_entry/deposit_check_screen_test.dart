// @dart = 2.9
import 'package:business_banking/features/deposit_check/model/2nd_data_entry/deposit_check_view_model.dart';
import 'package:business_banking/features/deposit_check/model/account_info_struct.dart';
import 'package:business_banking/features/deposit_check/ui/2nd_data_entry/deposit_check_presenter.dart';
import 'package:business_banking/features/deposit_check/ui/2nd_data_entry/deposit_check_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_driver/flutter_driver.dart' as drive;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockPressenterAction extends Mock
    implements DepositCheckPressenterActions {}

void main() {
  MaterialApp testWidget;
  MaterialApp testWidgetOnError;
  DepositCheckViewModel depositCheckViewModel;
  DepositCheckViewModel depositCheckViewModelOnError;
  MockPressenterAction mockPressenterAction;

  setUp(() {
    depositCheckViewModel = DepositCheckViewModel(
        accountInfo: AccountInfoStruct(
            accountNumber: '1234567890126917',
            availableBalance: 481.84,
            depositLimit: 4500.00,
            accountNickname: 'Checking Account (...6917)'),
        depositAmount: 200.0,
        frontCheckImg: '',
        backCheckImg: '',
        referenceNumber: '#1',
        userEmail: 'sample@hnb.com',
        depositAmountStatus: '',
        userEmailStatus: '');

    depositCheckViewModelOnError = DepositCheckViewModel(
        accountInfo: AccountInfoStruct(
            accountNumber: '1234567890126917',
            availableBalance: 481.84,
            depositLimit: 4500.00,
            accountNickname: 'Checking Account (...6917)'),
        depositAmount: 0.0,
        frontCheckImg: '',
        backCheckImg: '',
        referenceNumber: '',
        userEmail: '',
        depositAmountStatus: 'Please provide a value.',
        userEmailStatus: 'Please provide a value.');

    mockPressenterAction = MockPressenterAction();
    testWidget = MaterialApp(
      home: DepositCheckScreen(
          viewModel: depositCheckViewModel,
          pressenterAction: mockPressenterAction),
    );
    testWidgetOnError = MaterialApp(
      home: DepositCheckScreen(
          viewModel: depositCheckViewModelOnError,
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
      expect(
          find.text(
              'Deposit to ${depositCheckViewModel.accountInfo.accountNickname}'),
          findsOneWidget);
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

    testWidgets('should call navigate to Back page on presenter action',
        (tester) async {
      await tester.pumpWidget(testWidget);
      await tester.pump(Duration(milliseconds: 500));

      var widget = find.byKey(Key('Deposit-Check-Back-Button'));
      expect(widget, findsOneWidget);
      await tester.tap(widget);
      verify(mockPressenterAction.popNavigationListener(any)).called(1);
    });

    testWidgets('should call pick front image on presenter action',
        (tester) async {
      await tester.pumpWidget(testWidget);
      await tester.pump(Duration(milliseconds: 500));

      var widget = find.byKey(Key('Check-Front-Img-Button'));
      expect(widget, findsOneWidget);
      await tester.tap(widget);
      verify(mockPressenterAction.onPickFrontImg()).called(1);
    });
    testWidgets('should call pick back image on presenter action',
        (tester) async {
      await tester.pumpWidget(testWidget);
      await tester.pump(Duration(milliseconds: 500));

      var widget = find.byKey(Key('Check-Back-Img-Button'));
      expect(widget, findsOneWidget);
      await tester.tap(widget);
      verify(mockPressenterAction.onPickBackImg()).called(1);
    });
    testWidgets('should call confirm func on presenter action', (tester) async {
      await tester.pumpWidget(testWidget);

      await tester.drag(
          find.byKey(Key('Scroll-View-Key')), const Offset(0.0, -300));
      await tester.pump();

      var widget = find.byKey(Key('Deposit-Check-Confirm-Button'));
      await tester.pumpAndSettle();

      expect(widget, findsOneWidget);
      await tester.tap(widget);
      verify(mockPressenterAction.onTapConfirmBtn(any, any, any)).called(1);
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

    testWidgets('should show errors on view model with status error',
        (tester) async {
      await tester.pumpWidget(testWidgetOnError);

      await tester.pump(Duration(milliseconds: 500));

      await tester.pumpAndSettle();
      expect(find.text('Please provide a value.'), findsWidgets);
    });
  });
}
