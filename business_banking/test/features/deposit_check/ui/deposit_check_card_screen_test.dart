// @dart = 2.9
import 'package:business_banking/features/deposit_check/model/account_info_struct.dart';
import 'package:business_banking/features/deposit_check/model/deposit_check_view_model.dart';
import 'package:business_banking/features/deposit_check/ui/deposit_check_card_presenter.dart';
import 'package:business_banking/features/deposit_check/ui/deposit_check_card_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockPressenterAction extends Mock
    implements DepositCheckCardPressenterActions {}

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
        depositAmount: '',
        frontCheckImg: '',
        backCheckImg: '',
        referenceNumber: '');

    mockPressenterAction = MockPressenterAction();
    testWidget = MaterialApp(
      home: DepositCheckCardScreen(
          viewModel: depositCheckViewModel,
          pressenterActions: mockPressenterAction),
    );
  });

  tearDown(() {
    testWidget = null;
    mockPressenterAction = null;
  });
  group('Deposit Check Card', () {
    testWidgets('should shows the screen', (tester) async {
      await tester.pumpWidget(testWidget);
      await tester.pump(Duration(milliseconds: 500));

      final widgetType = find.byType(DepositCheckCardScreen);
      expect(widgetType, findsOneWidget);
    });

    testWidgets('should show Deposit Checks card detail', (tester) async {
      await tester.pumpWidget(testWidget);
      await tester.pump(Duration(milliseconds: 500));

      // Titel
      expect(find.text('Deposit Checks'), findsOneWidget);
      // Divider
      expect(find.byType(Divider), findsOneWidget);
      // Deposit Limit
      expect(
          find.text(
              'Your current mobile deposit limit is \$${depositCheckViewModel.accountInfo.depositLimit}'),
          findsOneWidget);
      // Account To be deposit Name
      expect(find.text(depositCheckViewModel.accountInfo.accountNickname),
          findsOneWidget);
      // Current Balance
      expect(
          find.text('\$${depositCheckViewModel.accountInfo.availableBalance}'),
          findsOneWidget);
    });

    testWidgets('should navigate to Deposit Check page', (tester) async {
      await tester.pumpWidget(testWidget);
      await tester.pump(Duration(milliseconds: 500));

      var widget = find.byKey(Key('depositCheckCard'));
      expect(widget, findsOneWidget);
      await tester.tap(widget);
      verify(mockPressenterAction.navigateToDepositCheck(any)).called(1);
    });
  });
}
