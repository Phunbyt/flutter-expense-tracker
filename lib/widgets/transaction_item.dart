// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
    required this.transaction,
    required this.themeContext,
    required this.deleteTx,
  }) : super(key: key);

  final Transaction transaction;
  final ThemeData themeContext;
  final Function deleteTx;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: EdgeInsets.all(6),
            child: FittedBox(
              child: Text("\$${transaction.amount}"),
            ),
          ),
        ),
        title: Text(
          transaction.title,
          style: themeContext.textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(transaction.date),
        ),
        trailing: MediaQuery.of(context).size.width > 350
            ? FlatButton.icon(
                onPressed: () => deleteTx(transaction.id),
                icon: Icon(Icons.delete),
                label: Text("Delete"),
                textColor: themeContext.errorColor)
            : IconButton(
                icon: Icon(Icons.delete),
                color: themeContext.errorColor,
                onPressed: () => deleteTx(transaction.id)),
      ),
    );
  }
}
