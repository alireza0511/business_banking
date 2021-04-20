import 'package:business_banking/features/budget/api/transactions_service.dart';
import 'package:business_banking/features/budget/bloc/budget_usecase.dart';
import 'package:business_banking/features/budget/bloc/list_transactions_usecase.dart';
import 'package:business_banking/features/budget/model/budget_view_model.dart';
import 'package:business_banking/features/budget/model/list_transactions_view_model.dart';
import 'package:clean_framework/clean_framework.dart';

class BudgetBloc extends Bloc {
  late BudgetUsecase _useCase;
  late ListTransactionsUseCase _listTransactionsUseCase;

  final budgetViewModelPipe = Pipe<BudgetViewModel>();
  final listTransactionsViewModelPipe = Pipe<ListTransactionsViewModel>();
  final chosenCategoryPipe = Pipe<String>();

  @override
  void dispose() {
    budgetViewModelPipe.dispose();
    listTransactionsViewModelPipe.dispose();
  }

  BudgetBloc({TransactionsService? transactionsService}) {
    _useCase = BudgetUsecase(
        (viewModel) => budgetViewModelPipe.send(viewModel as BudgetViewModel));
    budgetViewModelPipe.whenListenedDo(() => _useCase.create());

    _listTransactionsUseCase = ListTransactionsUseCase((viewModel) =>
        listTransactionsViewModelPipe
            .send(viewModel as ListTransactionsViewModel));
    listTransactionsViewModelPipe
        .whenListenedDo(() => _listTransactionsUseCase.create());

    chosenCategoryPipe.receive.listen(_didApplyFilter);
  }

  void _didApplyFilter(String value) {
    _listTransactionsUseCase.applyFilter(value);
  }
}
