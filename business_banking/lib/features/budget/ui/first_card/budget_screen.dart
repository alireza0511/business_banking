// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:business_banking/features/budget/model/budget_view_model.dart';
// import 'package:clean_framework/clean_framework.dart';
// import 'package:flutter/material.dart';

// class BudgetScreen extends Screen {
//   final BudgetViewModel viewModel;
//   final VoidCallback viewBudgetChartHandler;

//   BudgetScreen(
//       {required this.viewModel, required this.viewBudgetChartHandler});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height * 0.20,
//       padding: EdgeInsets.all(5.0),
//       child: Card(
//         color: Colors.white,
//         shadowColor: Colors.grey[500],
//         elevation: 3.0,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Expanded(
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: Text(
//                         viewModel.accountInfo!.accountNickname,
//                         style: TextStyle(
//                           fontSize: 18.0,
//                         ),
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                     AutoSizeText(
//                       ' \$' + viewModel.accountInfo!.availableBalance.toString(),
//                       style: TextStyle(
//                         fontSize: 18.0,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       "Account Number:",
//                       style: TextStyle(fontSize: 18.0),
//                     ),
//                     Text(
//                       viewModel.accountInfo!.accountNumber,
//                       style: TextStyle(fontSize: 18.0),
//                     )
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
//                 child: OutlinedButton(
//                   style: ButtonStyle(
//                     shape: MaterialStateProperty.all(
//                       RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(5.0),
//                       ),
//                     ),
//                   ),
//                   onPressed: () {
//                     viewBudgetChartHandler();
//                   },
//                   child: Text(
//                     'View Chart',
//                     style: TextStyle(color: Colors.black54),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
