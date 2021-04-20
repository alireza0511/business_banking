import 'package:business_banking/features/budget/model/budget_view_model.dart';
import 'package:business_banking/features/budget/ui/transactions_list/list_transactions_widget.dart';
import 'package:business_banking/features/budget/ui/widgets/donut_auto_label_chart.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/material.dart';

class ViewChartScreen extends Screen {
  final _scaffoldkey = new GlobalKey<ScaffoldState>();
  final BudgetViewModel viewModel;
  final Function didSelectCategory;

  ViewChartScreen({required this.viewModel, required this.didSelectCategory});

  @override
  Widget build(BuildContext context) {
    List<dynamic> categoryList = viewModel.allTransactions
        .map((array) => array.category)
        .toSet()
        .toList();

    _bottomSheet() {
      // to avoid multiple insertions
      if (categoryList.first != 'Show All') {
        // insert
        categoryList.insert(0, 'Show All');
      }
      return BottomSheet(
        onClosing: () {},
        builder: (context) {
          return Container(
            height: categoryList.length * 70.0,
            color: Colors.lightGreen,
            child: ListView(
              children: <Widget>[
                ButtonBar(
                  children: <Widget>[CloseButton()],
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  shrinkWrap: true,
                  itemCount: categoryList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        didSelectCategory(categoryList[index]);
                        Navigator.pop(context);
                      },
                      child: Center(
                        child: Container(
                          height: 50.0,
                          child: Text(
                            categoryList[index],
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      );
    }

    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text(viewModel.accountInfo!.accountNickname),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
            child: Center(
                child: Text(
              'Your Spendings',
              style: TextStyle(fontSize: 18),
            )),
          ),
          ConstrainedBox(
              constraints: BoxConstraints.loose(
                Size(
                  double.infinity,
                  MediaQuery.of(context).size.width / 1.8,
                ),
              ),
              child: DonutAutoLabelChart(
                  seriesList: viewModel.chartData, animate: false)),
          Divider(),
          OutlinedButton(
            child: Text('Select Category'),
            onPressed: () {
              _scaffoldkey.currentState!.showBottomSheet(
                (context) {
                  return _bottomSheet();
                },
              );
            },
          ),
          ListTransactionsWidget(),
        ],
      ),
    );
  }
}
