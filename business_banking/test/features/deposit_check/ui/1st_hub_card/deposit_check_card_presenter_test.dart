// @dart=2.9
import 'package:business_banking/features/deposit_check/model/1st_hub_card/deposit_check_card_view_model.dart';
import 'package:business_banking/features/deposit_check/model/account_info_struct.dart';
import 'package:business_banking/features/deposit_check/model/enums.dart';
import 'package:business_banking/features/deposit_check/ui/1st_hub_card/deposit_check_card_presenter.dart';
import 'package:business_banking/features/deposit_check/ui/1st_hub_card/deposit_check_card_widget.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../bloc/deposit_check_bloc_mock.dart';

class MockPressenterAction extends Mock
    implements DepositCheckCardPressenterActions {}

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  MockBuildContext mockBuildContext;
  DepositCheckCardViewModel depositCheckViewModelSucceed;
  MockPressenterAction mockPressenterAction;
  DepositCheckCardPressenterActions depositCheckCardPressenterActions;
  DepositCheckBlockMock mockBloc;
  MaterialApp testWidget;

  setUp(() {
    mockBuildContext = MockBuildContext();
    mockPressenterAction = MockPressenterAction();
    mockBloc = DepositCheckBlockMock();

    depositCheckViewModelSucceed = DepositCheckCardViewModel(
        accountInfo: AccountInfoStruct(
          accountNumber: '1234567890126917',
          availableBalance: 481.84,
          depositLimit: 4500.00,
          accountNickname: 'Checking Account (...6917)',
        ),
        serviceResponseStatus: ServiceResponseStatus.succeed);

    depositCheckCardPressenterActions = DepositCheckCardPressenterActions(
        mockBloc, depositCheckViewModelSucceed);

    testWidget = MaterialApp(
      home: BlocProvider<DepositCheckBlockMock>(
        create: (_) => DepositCheckBlockMock(),
        child: DepositCheckCardWidget(),
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

    test('description', () {
      mockBloc.depositCheckCardViewModelPipe.receive.listen((event) {
        expect(event.accountInfo, depositCheckViewModelSucceed.accountInfo);
      });

      verify(depositCheckCardPressenterActions
              .navigateToDepositCheck(mockBuildContext))
          .called(1);
    });
  });
}
