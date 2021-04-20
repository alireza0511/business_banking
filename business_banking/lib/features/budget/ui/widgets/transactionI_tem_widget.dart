import 'package:business_banking/features/budget/model/list_transactions_view_model.dart';
import 'package:flutter/material.dart';

class TransactionItemWidget extends StatelessWidget {
  final ListTransactionsViewModel viewModel;
  final rowIndex;

  const TransactionItemWidget(
      {Key? key, required this.viewModel, required this.rowIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44.0,
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(viewModel.filteredTransactions[rowIndex].description),
                Text('\$' +
                    viewModel.filteredTransactions[rowIndex].debitAmount
                        .toString()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
