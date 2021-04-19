// import 'package:business_banking/features/budget/model/account_info.dart';
// import 'package:business_banking/features/budget/model/chart_data_model.dart';
// import 'package:business_banking/features/budget/model/posted_transactions.dart';
// import 'package:clean_framework/clean_framework.dart';
// import 'package:flutter/material.dart';
// import 'package:charts_flutter/flutter.dart' as charts;

// enum TransactionsServiceStatus { success, fail, unknown }

// class BudgetViewModel extends ViewModel {
//   final AccountInfo? accountInfo;
//   final List<PostedTransactions> allTransactions;
//   final List<charts.Series<ChartDataModel, int>> chartData;
//   final TransactionsServiceStatus? serviceStatus;

//   BudgetViewModel(
//       {Key? key,
//       required this.accountInfo,
//       required this.allTransactions,
//       required this.chartData,
//       this.serviceStatus});

//   @override
//   // TODO: implement props
//   List<Object?> get props =>
//       [accountInfo, allTransactions, chartData, serviceStatus];
// }
