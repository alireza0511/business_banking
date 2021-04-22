// @dart = 2.9
import 'package:business_banking/features/deposit_check/model/account_info_view_model.dart';
import 'package:business_banking/features/deposit_check/ui/card/deposit_check_card_presenter.dart';
import 'package:business_banking/features/deposit_check/ui/card/deposit_check_card_screen.dart';
import 'package:business_banking/features/deposit_check/ui/card/deposit_check_card_widget.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../bloc/deposit_check_bloc_mock.dart';

class MockPressenterAction extends Mock
    implements DepositCheckCardPressenterActions {}

void main() {
  MaterialApp testWidget;
  AccountInfoViewModel accountInfoViewModel;
  MockPressenterAction mockPressenterAction;

  setUp(() {
    accountInfoViewModel = AccountInfoViewModel(
        accountNumber: '1234567890126917',
        availableBalance: 481.84,
        depositLimit: 4500.00,
        accountNickname: 'Checking Account (...6917)');

    mockPressenterAction = MockPressenterAction();
    testWidget = MaterialApp(
      home: DepositCheckCardScreen(
          viewModel: accountInfoViewModel,
          pressenterActions: mockPressenterAction),
    );
  });

  tearDown(() {
    testWidget = null;
    accountInfoViewModel = null;
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
              'Your current mobile deposit limit is \$${accountInfoViewModel.depositLimit}'),
          findsOneWidget);
      // Account To be deposit Name
      expect(find.text(accountInfoViewModel.accountNickname), findsOneWidget);
      // Current Balance
      expect(find.text('\$${accountInfoViewModel.availableBalance}'),
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
