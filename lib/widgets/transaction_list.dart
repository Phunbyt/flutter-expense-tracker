// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../models/transaction.dart';
import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  TransactionList(
      {Key? key, required this.transactions, required this.deleteTx})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeContext = Theme.of(context);

    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: [
                Text(
                  "No transactions added yet",
                  style: themeContext.textTheme.headline6,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    "assets/images/waiting.png",
                  ),
                ),
              ],
            );
          })
        : ListView.builder(
            itemBuilder: ((context, index) {
              return TransactionItem(
                  transaction: transactions[index],
                  themeContext: themeContext,
                  deleteTx: deleteTx);
            }),
            itemCount: transactions.length,
          );
  }
}

