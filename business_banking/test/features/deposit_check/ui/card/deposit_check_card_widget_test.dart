// @dart = 2.9
import 'package:business_banking/features/deposit_check/ui/card/deposit_check_card_presenter.dart';
import 'package:business_banking/features/deposit_check/ui/card/deposit_check_card_widget.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../bloc/deposit_check_bloc_mock.dart';

void main() {
  MaterialApp testWidget;

  setUp(() {
    testWidget = testWidget = MaterialApp(
      home: BlocProvider<DepositCheckBlockMock>(
        create: (_) => DepositCheckBlockMock(),
        child: DepositCheckCardFeatureWidget(),
      ),
    );
  });

  group('Deposit Check Card', () {
    testWidgets('should shows the presenter', (tester) async {
      // pumpWidget calls runApp, and also triggers a frame to paint the app.
      await tester.pumpWidget(testWidget);
      //pump trigger a rebuild since the data-loading process will happen post-runApp.
      await tester.pump(Duration(milliseconds: 500));

      final widgetType = find.byType(DepositCheckCardPresenter);
      expect(widgetType, findsOneWidget);
    });

    testWidgets('should show \"Deposit Checks\" at title of card',
        (tester) async {
      // pumpWidget calls runApp, and also triggers a frame to paint the app.
      await tester.pumpWidget(testWidget);
      //pump trigger a rebuild since the data-loading process will happen post-runApp.
      await tester.pump(Duration(milliseconds: 500));

      final Finder finder = find.text('Deposit Checks');
      expect(finder, findsWidgets);
    });

    testWidgets('should show \"current deposit limit\" at top of acount name',
        (tester) async {
      // pumpWidget calls runApp, and also triggers a frame to paint the app.
      await tester.pumpWidget(testWidget);
      //pump trigger a rebuild since the data-loading process will happen post-runApp.
      await tester.pump(Duration(milliseconds: 500));

      final Finder finder =
          find.text('Your current mobile deposit limit is \$15,000.00');
      expect(finder, findsWidgets);
    });
  });
}
