// import 'package:business_banking/features/budget/bloc/budget_bloc.dart';
// import 'package:business_banking/features/budget/model/budget_view_model.dart';
// import 'package:business_banking/features/budget/ui/first_card/budget_screen.dart';
// import 'package:business_banking/routes.dart';
// import 'package:clean_framework/clean_framework.dart';
// import 'package:flutter/material.dart';

// class BudgetPresenter
//     extends Presenter<BudgetBloc, BudgetViewModel, BudgetScreen> {
//   @override
//   BudgetScreen buildScreen(
//       BuildContext context, BudgetBloc bloc, BudgetViewModel viewModel) {
//     // implement buildScreen
//     return BudgetScreen(
//       viewModel: viewModel,
//       viewBudgetChartHandler: () {
//         CFRouterScope.of(context)
//             .push(BusinessBankingRouter.viewBudgetChartRoute);
//       },
//     );
//   }

//   @override
//   Stream<BudgetViewModel> getViewModelStream(BudgetBloc bloc) {
//     // implement getViewModelStream
//     return bloc.budgetViewModelPipe.receive;
//   }
// }
