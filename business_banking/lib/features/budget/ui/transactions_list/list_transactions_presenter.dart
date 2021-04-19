// import 'package:business_banking/features/budget/bloc/budget_bloc.dart';
// import 'package:business_banking/features/budget/model/list_transactions_view_model.dart';
// import 'package:business_banking/features/budget/ui/transactions_list/list_transactions_screen.dart';
// import 'package:clean_framework/clean_framework.dart';
// import 'package:flutter/material.dart';

// class ListTransactionsPresenter extends Presenter<BudgetBloc,
//     ListTransactionsViewModel, ListTransactionsScreen> {
//   @override
//   ListTransactionsScreen buildScreen(BuildContext context, BudgetBloc bloc,
//       ListTransactionsViewModel viewModel) {
//     // implement buildScreen
//     return ListTransactionsScreen(viewModel: viewModel);
//   }

//   @override
//   Stream<ListTransactionsViewModel> getViewModelStream(BudgetBloc bloc) {
//     // implement getViewModelStream
//     return bloc.listTransactionsViewModelPipe.receive;
//   }

//   @override
//   Widget buildLoadingScreen(BuildContext context) {
//     return Center(
//       child: CircularProgressIndicator(),
//     );
//   }
// }
