// @dart = 2.9
import 'package:business_banking/features/deposit_check/ui/page/deposit_check_feature_widget.dart';
import 'package:business_banking/features/deposit_check/ui/page/deposit_check_presenter.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../bloc/deposit_check_bloc_mock.dart';

class DepositCheckPresenterActionsMock extends Mock
    implements DepositCheckPressenterActions {}

void main() {
  MaterialApp testWidget;
  DepositCheckPresenterActionsMock depositCheckPresenterActionsMock;

  setUp(() {
    testWidget = testWidget = MaterialApp(
      home: BlocProvider<DepositCheckBlockMock>(
        create: (_) => DepositCheckBlockMock(),
        child: DepositCheckWidget(),
      ),
    );

    depositCheckPresenterActionsMock = DepositCheckPresenterActionsMock();
  });

  group('Deposit Check', () {
    testWidgets('should shows the presenter', (tester) async {
      // pumpWidget calls runApp, and also triggers a frame to paint the app.
      await tester.pumpWidget(testWidget);
      //pump trigger a rebuild since the data-loading process will happen post-runApp.
      await tester.pump(Duration(milliseconds: 500));

      final widgetType = find.byType(DepositCheckPresenter);
      expect(widgetType, findsOneWidget);
    });

    test('description', () {});
  });
}
