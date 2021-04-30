// @dart = 2.9
import 'package:business_banking/features/deposit_check/model/1st_hub_card/deposit_check_card_view_model.dart';
import 'package:business_banking/features/deposit_check/model/account_info_struct.dart';
import 'package:business_banking/features/deposit_check/model/enums.dart';
import 'package:business_banking/features/deposit_check/ui/1st_hub_card/deposit_check_card_presenter.dart';
import 'package:business_banking/features/deposit_check/ui/1st_hub_card/deposit_check_card_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockPressenterAction extends Mock
    implements DepositCheckCardPressenterActions {}

void main() {
  MaterialApp testWidgetSucceed;
  MaterialApp testWidgetFailed;
  DepositCheckCardViewModel depositCheckViewModelSucceed;
  DepositCheckCardViewModel depositCheckViewModelFailed;
  MockPressenterAction mockPressenterAction;

  setUp(() {
    depositCheckViewModelSucceed = DepositCheckCardViewModel(
        accountInfo: AccountInfoStruct(
          accountNumber: '1234567890126917',
          availableBalance: 481.84,
          depositLimit: 4500.00,
          accountNickname: 'Checking Account (...6917)',
        ),
        serviceResponseStatus: ServiceResponseStatus.succeed);

    depositCheckViewModelFailed = DepositCheckCardViewModel(
        accountInfo: AccountInfoStruct(
          accountNumber: '1234567890126917',
          availableBalance: 481.84,
          depositLimit: 4500.00,
          accountNickname: 'Checking Account (...6917)',
        ),
        serviceResponseStatus: ServiceResponseStatus.failed);

    mockPressenterAction = MockPressenterAction();

    testWidgetSucceed = MaterialApp(
      home: DepositCheckCardScreen(
          viewModel: depositCheckViewModelSucceed,
          pressenterActions: mockPressenterAction),
    );

    testWidgetFailed = MaterialApp(
      home: DepositCheckCardScreen(
          viewModel: depositCheckViewModelFailed,
          pressenterActions: mockPressenterAction),
    );
  });

  tearDown(() {
    depositCheckViewModelSucceed = null;
    depositCheckViewModelFailed = null;
    mockPressenterAction = null;
  });
  group('Deposit Check Card', () {
    testWidgets('should shows the screen', (tester) async {
      await tester.pumpWidget(testWidgetSucceed);
      await tester.pump(Duration(milliseconds: 500));

      final widgetType = find.byType(DepositCheckCardScreen);
      expect(widgetType, findsOneWidget);
    });

    testWidgets(
        'should show account info on Deposit Check card with succeed response',
        (tester) async {
      await tester.pumpWidget(testWidgetSucceed);
      await tester.pump(Duration(milliseconds: 500));

      // Titel
      expect(find.text('Deposit Checks'), findsOneWidget);
      // Divider
      expect(find.byType(Divider), findsOneWidget);
      // Deposit Limit
      expect(
          find.text(
              'Your current mobile deposit limit is \$${depositCheckViewModelSucceed.accountInfo.depositLimit}'),
          findsOneWidget);
      // Account To be deposit Name
      expect(
          find.text(depositCheckViewModelSucceed.accountInfo.accountNickname),
          findsOneWidget);
      // Current Balance
      expect(
          find.text(
              '\$${depositCheckViewModelSucceed.accountInfo.availableBalance}'),
          findsOneWidget);
    });

//! why it can not cover the test for presenter action?
    testWidgets('should navigate to Deposit Check page', (tester) async {
      await tester.pumpWidget(testWidgetSucceed);
      await tester.pump(Duration(milliseconds: 500));

      var widget = find.byKey(Key('Deposit-Check-Card-Succeed'));
      expect(widget, findsOneWidget);
      await tester.tap(widget);
      verify(mockPressenterAction.navigateToDepositCheck(any)).called(1);
    });

    testWidgets('should show Deposit Check card when response Failed',
        (tester) async {
      await tester.pumpWidget(testWidgetFailed);
      await tester.pump(Duration(milliseconds: 500));

      // Titel
      expect(find.text('Deposit Checks'), findsOneWidget);
      // Divider
      expect(find.byType(Divider), findsOneWidget);
      // Deposit Limit
      expect(find.text('Service is not available! Please try again later.'),
          findsOneWidget);
    });

    testWidgets('should not navigate to Deposit Check page on Failed Response',
        (tester) async {
      await tester.pumpWidget(testWidgetFailed);
      await tester.pump(Duration(milliseconds: 500));

      var widget = find.byKey(Key('Deposit-Check-Card-Failed'));
      expect(widget, findsOneWidget);
      await tester.tap(widget);
      verifyNever(mockPressenterAction.navigateToDepositCheck(any));
    });
  });
}
