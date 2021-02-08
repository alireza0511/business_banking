import 'package:business_banking/features/side_cash_enrollment/bloc/side_cash_enrollment_bloc.dart';
import 'package:business_banking/features/side_cash_enrollment/ui/side_cash_enrollment_form_feature_widget.dart';
import 'package:business_banking/features/side_cash_enrollment/ui/side_cash_enrollment_form_presenter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mocks/mock_side_cash_enrollment_bloc.dart';

main() {
  group("side cash enrollment feature widget tests", () {
    testWidgets("BuildWhenAvailable will create a presenter ", (tester) async {
      final widget = MaterialApp(
          home: SideCashEnrollmentFormFeatureWidget(
        bloc: MockSideCashEnrollmentBloc(),
      ));
      await tester.pumpWidget(widget);
      expect(find.byType(SideCashEnrollmentFormPresenter), findsOneWidget);
    });

    testWidgets(
        "BuildWhenAvailable will NOT create a presenter when feature flag is disabled",
        (tester) {});
  });
}