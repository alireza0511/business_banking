import 'dart:convert';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:business_banking/features/deposit_check/model/account_info_view_model.dart';
import 'package:business_banking/features/deposit_check/model/deposit_check_view_model.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/material.dart';

import 'deposit_check_presenter.dart';

class DepositCheckScreen extends Screen {
  //final AccountInfoViewModel viewModel;
  final DepositCheckViewModel viewModel;
  final DepositCheckPressenterActions pressenterAction;

  DepositCheckScreen({required this.viewModel, required this.pressenterAction});
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
              pressenterAction.popNavigationListener(context);
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
                  "Deposit to CHECKING ACCOUNT",
                  //"Deposit to \n${viewModel.accountNickname} \n\$${viewModel.availableBalance}",
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
                          child: viewModel.frontCheckImg.isNotEmpty
                              ? Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Image.memory(
                                        base64.decode(viewModel.frontCheckImg)),
                                    Icon(
                                      Icons.check,
                                      color: Colors.green,
                                      size: 50,
                                    )
                                  ],
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Front of Check'),
                                    Icon(Icons.camera_alt)
                                  ],
                                ),
                        ),
                        onTap: () {
                          pressenterAction.onPickFrontImg();
                        },
                      ),
                      GestureDetector(
                        child: Container(
                          height: 150,
                          width: 160,
                          color: Colors.grey[300],
                          child: viewModel.backCheckImg.isNotEmpty
                              ? Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Image.memory(
                                        base64.decode(viewModel.backCheckImg)),
                                    Icon(
                                      Icons.check,
                                      color: Colors.green,
                                      size: 50,
                                    )
                                  ],
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Back of Check'),
                                    Icon(Icons.camera_alt)
                                  ],
                                ),
                        ),
                        onTap: () {
                          pressenterAction.onPickBackImg();
                        },
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
                          onSaved: (val) => pressenterAction
                              .onDepositCheckAmountSavedListener(val ?? ''),
                          // .onFormSavedListener({'amount': val ?? ''}),
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
                            } else {
                              return pressenterAction.onRegExValidation(value);
                            }
                            //return null;
                          },
                          onSaved: (val) =>
                              pressenterAction.onFormSavedListener(val ?? ''),
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
                    onPressed: () {
                      //! it should be here or move to presenter
                      if (_form.currentState != null) {
                        final isValid = _form.currentState!.validate();
                        if (isValid == false) return;
                        _form.currentState!.save();

                        pressenterAction.onTapConfirm(context, viewModel);
                      }
                    },
                  ),
                ),
              )
            ],
          )),
        ));
  }
}
