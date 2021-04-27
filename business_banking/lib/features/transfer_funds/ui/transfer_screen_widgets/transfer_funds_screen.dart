import 'package:business_banking/features/transfer_funds/model/transfer_view_model.dart';
import 'package:business_banking/features/transfer_funds/ui/transfer_screen_widgets/from_accounts_dropdown.dart';
import 'package:business_banking/features/transfer_funds/ui/transfer_screen_widgets/to_accounts_dropdown.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class TransferFundsScreen extends Screen {
  final TransferFundsViewModel viewModel;
  final Function onChangeSelectedFromAccount;
  final Function onChangeSelectedToAccount;
  final Function onChangeAmount;
  final Function onChangeDate;
  final VoidCallback onTapSubmit;

  TransferFundsScreen(
      {required this.viewModel,
      required this.onChangeSelectedFromAccount,
      required this.onChangeSelectedToAccount,
      required this.onChangeAmount,
      required this.onChangeDate,
      required this.onTapSubmit});

  @override
  Widget build(BuildContext context) {
    final _controller = TextEditingController();
    _controller.text = viewModel.amount;
    _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Transfer Funds', key: Key('transfer_funds_bar_title')),
      ),
      body: Container(
        margin: new EdgeInsets.all(15.0),
        child: ListView(children: <Widget>[
          Container(
            child: Text(
              'From',
              key: Key('from_label'),
            ),
            width: double.infinity,
          ),
          FromAccountsDropDown(
              key: Key('from_account_dropdown'),
              viewModel: viewModel,
              onChangeSelectedFromAccount: onChangeSelectedFromAccount),
          SizedBox(height: 15.0),
          Text('To', key: Key('to_label')),
          SizedBox(height: 5.0),
          ToAccountsDropDown(
            key: Key('to_account_dropdown'),
            viewModel: viewModel,
            onChangeSelectedToAccount: onChangeSelectedToAccount,
          ),
          SizedBox(height: 15.0),
          Text('Amount', key: Key('amount_label')),
          SizedBox(height: 15.0),
          TextField(
            key: Key('amount_text_field'),
            onChanged: (String value) {
              (value);
            },
            keyboardType: TextInputType.number,
            controller: _controller,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
            ],
            decoration: InputDecoration(
              isDense: true,
              prefixIcon: Text('\$ '),
              prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
            ),
          ),
          SizedBox(height: 20.0),
          Text('Transfer date', key: Key('date_label')),
          SizedBox(
            height: 15.0,
          ),
          TextField(
            key: Key('date_text_field'),
            controller: TextEditingController()
              ..text = DateFormat('MM/dd/yyyy').format(viewModel.date!),
            onTap: () {
              showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2021))
                  .then((date) {
                onChangeDate(date);
              });
            },
            readOnly: true,
          ),
          SizedBox(height: 15.0),
          RaisedButton(
            key: Key('submit_transfer_button'),
            textColor: Colors.white,
            color: Colors.black54,
            child: Text('Submit Transfer'),
            onPressed: () {
              onTapSubmit();
            },
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0),
            ),
          )
        ]),
      ),
    );
  }
}
