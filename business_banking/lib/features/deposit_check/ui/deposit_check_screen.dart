import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:business_banking/features/deposit_check/model/account_info_view_model.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/material.dart';

class DepositCheckScreen extends Screen {
  final AccountInfoViewModel viewModel;
  final VoidCallback navigateToDepositCheckDetail;

  DepositCheckScreen(
      {required this.viewModel, required this.navigateToDepositCheckDetail});
  final _form = GlobalKey<FormState>();
  final _emailFNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff2f2f2),
        appBar: AppBar(
          backgroundColor: Colors.green,
          leading: GestureDetector(
            child: Icon(
              Icons.chevron_left,
              size: 40.0,
            ),
            onTap: () {
              //navigateToAccountDetail();
            },
            key: Key('investment-detail-backButton'),
          ),
          title: AutoSizeText(
            'DEPOSIT CHECKS',
            maxFontSize: 16,
            minFontSize: 10,
          ),
        ),
        body: Align(
          alignment: Alignment.topLeft,
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Deposit to \n${viewModel.accountNickname} \n\$${viewModel.availableBalance}",
                  style: TextStyle(color: Colors.black54, fontSize: 15),
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        child: Container(
                          height: 150,
                          width: 160,
                          color: Colors.grey[300],
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Front of Check'),
                              Icon(Icons.camera_alt)
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                      GestureDetector(
                        child: Container(
                          height: 150,
                          width: 160,
                          color: Colors.grey[300],
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Back of Check'),
                              Icon(Icons.camera_alt)
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ),
              Form(
                  key: _form,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.attach_money_outlined),
                              suffixStyle:
                                  TextStyle(color: Colors.orangeAccent),
                              labelText: 'Deposit Amount'),
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(_emailFNode);
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please provide a value.';
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          initialValue: '',
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.email_outlined),
                              suffixStyle:
                                  TextStyle(color: Colors.orangeAccent),
                              labelText: 'Email Address'),
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.done,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please provide a value.';
                            }
                          },
                        ),
                      )
                    ],
                  )),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '''Deposit by 11 PM ET and your money will typical be available for withdrawl by next business day.''',
                  style: TextStyle(color: Colors.black54, fontSize: 15),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton(
                    child: Text('Confirm'),
                    onPressed: () {},
                  ),
                ),
              )
            ],
          )),
        ));
  }
}
