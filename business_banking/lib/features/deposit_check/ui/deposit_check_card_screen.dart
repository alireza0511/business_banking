import 'dart:ui';

import 'package:business_banking/features/deposit_check/model/deposit_check_view_model.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/material.dart';

import 'deposit_check_card_presenter.dart';

class DepositCheckCardScreen extends Screen {
  final DepositCheckViewModel viewModel;
  final DepositCheckCardPressenterActions pressenterActions;

  DepositCheckCardScreen(
      {required this.viewModel, required this.pressenterActions});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ItemCard(
        viewModel: viewModel,
        key: Key('depositCheckCard'),
      ),
      onTap: () {
        pressenterActions.navigateToDepositCheck(context);
      },
    );
  }
}

class ItemCard extends StatelessWidget {
  const ItemCard({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final DepositCheckViewModel viewModel;

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
                  ],
                ),
              ),
              const Divider(
                thickness: 2,
              ),
              Text(
                "Your current mobile deposit limit is \$${viewModel.accountInfo!.depositLimit}",
                style: TextStyle(color: Colors.black54, fontSize: 15),
              ),
              Text(
                '${viewModel.accountInfo!.accountNickname}',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(
                  '\$${viewModel.accountInfo!.availableBalance}',
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
