// ignore_for_file: deprecated_member_use
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction({Key? key, required this.addTx}) : super(key: key);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  void _submitData() {
    final _enteredTitle = _titleController.text;
    final _enteredAmount = double.parse(_amountController.text);

    if (_enteredTitle.isEmpty || _enteredAmount <= 0) {
      return;
    }

    widget.addTx(
      _enteredTitle,
      _enteredAmount,
      _selectedDate,
    );

    // Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeContext = Theme.of(context);

    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitData(),
              ),
              Container(
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                            "Picked Date: ${DateFormat.MMMEd().format(_selectedDate)}")),
                    Platform.isIOS
                        ? CupertinoButton(
                            child: Text("Choose Date"),
                            onPressed: _presentDatePicker,
                          )
                        : FlatButton(
                            child: Text("Choose Date",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            textColor: themeContext.primaryColor,
                            onPressed: _presentDatePicker,
                          ),
                  ],
                ),
              ),
              RaisedButton(
                child: Text('Add Transaction'),
                color: themeContext.primaryColor,
                textColor: themeContext.textTheme.button?.color,
                onPressed: _submitData,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
