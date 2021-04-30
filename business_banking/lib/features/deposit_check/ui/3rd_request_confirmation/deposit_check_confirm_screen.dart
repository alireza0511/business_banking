import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:business_banking/features/deposit_check/model/3rd_request_confirmation/deposit_check_confirm_view_model.dart';
import 'package:business_banking/features/deposit_check/model/enums.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/material.dart';

import 'deposit_check_confirm_presenter.dart';

class DepositCheckConfirmScreen extends Screen {
  final DepositCheckConfirmViewModel viewModel;
  final DepositCheckConfirmPressenterActions pressenterAction;

  DepositCheckConfirmScreen(
      {required this.viewModel, required this.pressenterAction});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff2f2f2),
        appBar: AppBar(
          backgroundColor: Colors.green,
          leading: GestureDetector(
            child: Icon(
              Icons.close,
              size: 40.0,
            ),
            onTap: () {
              pressenterAction.popNavigationListener(context);
            },
            key: Key('Deposit-Check-Confirm-Close-Button'),
          ),
          title: AutoSizeText(
            'CONFIRMATION',
            maxFontSize: 16,
            minFontSize: 10,
          ),
        ),
        body: viewModel.serviceResponseStatus == ServiceResponseStatus.succeed
            ? _succeedWidget(viewModel: viewModel)
            : _failedWidget(viewModel: viewModel));
  }
}

class _succeedWidget extends StatelessWidget {
  const _succeedWidget({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final DepositCheckConfirmViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Deposit to " + viewModel.accountInfo.accountNickname,
              style: TextStyle(color: Colors.black54, fontSize: 15),
              textAlign: TextAlign.left,
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Front of Check'),
                  Container(
                    height: 150,
                    width: double.infinity,
                    color: Colors.grey[300],
                    child: viewModel.frontCheckImg.isNotEmpty
                        ? Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.file(
                                File(viewModel.frontCheckImg),
                                fit: BoxFit.fill,
                              ),
                              Icon(
                                Icons.check,
                                color: Colors.green,
                                size: 50,
                              )
                            ],
                          )
                        : Image.asset(
                            'assets/images/img-icon.png',
                            fit: BoxFit.scaleDown,
                            scale: 10,
                          ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Back of Check'),
                  Container(
                    height: 150,
                    width: double.infinity,
                    color: Colors.grey[300],
                    child: viewModel.backCheckImg.isNotEmpty
                        ? Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.file(
                                File(viewModel.backCheckImg),
                                fit: BoxFit.fill,
                              ),
                              Icon(
                                Icons.check,
                                color: Colors.green,
                                size: 50,
                              )
                            ],
                          )
                        : Image.asset(
                            'assets/images/img-icon.png',
                            fit: BoxFit.scaleDown,
                            scale: 10,
                          ),
                  ),
                ],
              ),
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 180,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Deposit Amount'),
                  Text(
                    '\$${viewModel.depositAmount}',
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: 40,
                      decoration: TextDecoration.underline,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Reference Number'),
                  Text(viewModel.referenceNumber),
                ],
              ),
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '''Money from deposits may not be available for immediate withdrawal. Our general policy is to allow you to withdraw money deposited in your account no later than the first business day after the day we receive your deposit.''',
              style: TextStyle(color: Colors.black54, fontSize: 15),
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(height: 50),
        ],
      )),
    );
  }
}

class _failedWidget extends StatelessWidget {
  const _failedWidget({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final DepositCheckConfirmViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Deposit to " + viewModel.accountInfo.accountNickname,
              style: TextStyle(color: Colors.black54, fontSize: 15),
              textAlign: TextAlign.left,
            ),
          ),
          Divider(),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Container(
          //     height: 200,
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.spaceAround,
          //       children: [
          //         Text('Front of Check'),
          //         Container(
          //           height: 150,
          //           width: double.infinity,
          //           color: Colors.grey[300],
          //           child: viewModel.frontCheckImg.isNotEmpty
          //               ? Stack(
          //                   alignment: Alignment.center,
          //                   children: [
          //                     Image.memory(
          //                       base64.decode(viewModel.frontCheckImg),
          //                       fit: BoxFit.fill,
          //                     ),
          //                     Icon(
          //                       Icons.cancel,
          //                       color: Colors.red,
          //                       size: 50,
          //                     )
          //                   ],
          //                 )
          //               : Column(
          //                   mainAxisAlignment: MainAxisAlignment.center,
          //                   children: [Icon(Icons.camera_alt)],
          //                 ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Container(
          //     height: 200,
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.spaceAround,
          //       children: [
          //         Text('Back of Check'),
          //         Container(
          //           height: 150,
          //           width: double.infinity,
          //           color: Colors.grey[300],
          //           child: viewModel.backCheckImg.isNotEmpty
          //               ? Stack(
          //                   alignment: Alignment.center,
          //                   children: [
          //                     Image.memory(
          //                       base64.decode(viewModel.backCheckImg),
          //                       fit: BoxFit.fill,
          //                     ),
          //                     Icon(
          //                       Icons.check,
          //                       color: Colors.green,
          //                       size: 50,
          //                     )
          //                   ],
          //                 )
          //               : Column(
          //                   mainAxisAlignment: MainAxisAlignment.center,
          //                   children: [Icon(Icons.camera_alt)],
          //                 ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          // Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 180,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Deposit Amount'),
                  Text(
                    '\$${viewModel.depositAmount}',
                    style: TextStyle(
                        color: Colors.black45,
                        fontSize: 40,
                        decoration: TextDecoration.lineThrough,
                        decorationColor: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Text('Reference Number'),
                  Text(
                    'Please try again later!',
                    style: TextStyle(color: Colors.red, fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
          // Divider(),
          // Padding(
          //   padding: const EdgeInsets.all(16.0),
          //   child: Text(
          //     '''Please try again.''',
          //     style: TextStyle(color: Colors.black54, fontSize: 15),
          //     textAlign: TextAlign.left,
          //   ),
          // ),
          SizedBox(height: 50),
        ],
      )),
    );
  }
}
