import 'dart:ui';

import 'package:business_banking/features/deposit_check/model/account_info_view_model.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/material.dart';

class DepositCheckCardScreen extends Screen {
  final AccountInfoViewModel viewModel;
  final VoidCallback navigateToDepositCheck;

  DepositCheckCardScreen(
      {required this.viewModel, required this.navigateToDepositCheck});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ItemCard(
        viewModel: viewModel,
        key: Key('depositCheckCard'),
      ),
      onTap: () {
        navigateToDepositCheck();
      },
    );
  }
}

class ItemCard extends StatelessWidget {
  const ItemCard({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final AccountInfoViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      padding: EdgeInsets.all(5.0),
      child: Card(
        color: Colors.white,
        shadowColor: Colors.grey[500],
        elevation: 3.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Row(
                  children: [
                    Expanded(
                      child: const Text(
                        'Deposit Checks',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // const Icon(
                    //   Icons.arrow_forward_ios_rounded,
                    //   color: Colors.grey,
                    // )
                  ],
                ),
              ),
              const Divider(
                thickness: 2,
              ),
              const Text(
                "Your current mobile deposit limit is \$15,000.00",
                style: TextStyle(color: Colors.black54, fontSize: 15),
              ),
              Text(
                '${viewModel.accountNickname}',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(
                  '\$${viewModel.availableBalance}',
                  style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
