// import 'package:business_banking/features/budget/bloc/budget_service_adapter.dart';
// import 'package:business_banking/features/budget/model/budget_entity.dart';
// import 'package:business_banking/features/budget/model/budget_view_model.dart';
// import 'package:business_banking/features/budget/model/chart_data_model.dart';
// import 'package:business_banking/locator.dart';
// import 'package:clean_framework/clean_framework.dart';
// import 'package:clean_framework/clean_framework_defaults.dart';
// import 'package:charts_flutter/flutter.dart' as charts;

// class BudgetUsecase extends UseCase {
//   Function(ViewModel) _viewModelCallBack;

//   RepositoryScope? _scope;

//   BudgetUsecase(Function(ViewModel) viewModelCallBack)
//       : assert(viewModelCallBack != null),
//         _viewModelCallBack = viewModelCallBack;

//   void create() async {
//     _scope = ExampleLocator().repository.containsScope<BudgetEntity>();
//     if (_scope == null) {
//       final newEntity = BudgetEntity();
//       _scope = ExampleLocator()
//           .repository
//           .create<BudgetEntity>(newEntity, _notifySubscribers);
//     } else {
//       _scope!.subscription = _notifySubscribers;
//     }

//     await ExampleLocator()
//         .repository
//         .runServiceAdapter(_scope!, BudgetServiceAdapter());
//   }

//   void _notifySubscribers(entity) {
//     _buildViewModelForServiceUpdate(entity);
//   }

//   _buildViewModelForServiceUpdate(BudgetEntity entity) {
//     final _chartData = _createSampleData(entity);
//     if (entity.hasErrors()) {
//       _viewModelCallBack(BudgetViewModel(
//           accountInfo: entity.accountInfo,
//           allTransactions: entity.allTransactions!,
//           serviceStatus: TransactionsServiceStatus.fail, chartData: _chartData));
//     } else {
//       _viewModelCallBack(BudgetViewModel(
//           accountInfo: entity.accountInfo,
//           allTransactions: entity.allTransactions!,
//           serviceStatus: TransactionsServiceStatus.success, chartData: _chartData));
//     }
//   }

//   /// Create one series with sample hard coded data.
//   static List<charts.Series<ChartDataModel, int>> _createSampleData(BudgetEntity entity) {
//     final data = [
//       new ChartDataModel(
//           0, 10, 'gas', charts.MaterialPalette.red.shadeDefault.lighter),
//       new ChartDataModel(
//           1, 75, 'groceries', charts.MaterialPalette.green.shadeDefault),
//       new ChartDataModel(
//           2, 25, 'parking', charts.MaterialPalette.blue.shadeDefault),
//       new ChartDataModel(
//           3, 5, 'tolls', charts.MaterialPalette.yellow.shadeDefault),
//     ];

//     return [
//       new charts.Series<ChartDataModel, int>(
//         id: 'budget',
//         domainFn: (ChartDataModel sales, _) => sales.segmentIndex,
//         measureFn: (ChartDataModel sales, _) => sales.segmentTotal,
//         colorFn: (ChartDataModel sales, _) => sales.segmentColor,
//         data: data,
//         // Set a label accessor to control the text of the arc label.
//         labelAccessorFn: (ChartDataModel row, _) => '${row.segmentLabel}: ${row.segmentTotal}',
//       )
//     ];
//   }
// }
