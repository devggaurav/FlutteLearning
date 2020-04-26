import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  DateTime dateController;

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || dateController == null) {
      return;
    }

    widget.addTx(titleController.text, double.parse(amountController.text),
        dateController);
    Navigator.of(context).pop();
  }

  void presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        dateController = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          //to scroll bottom sheet edit text, while soft keyboard is open
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: titleController,
                onSubmitted: (_) => submitData(),
                /*   onChanged: (value){

                      },*/
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submitData(),
                /*onChanged: (value){
                        amountInput = value;
                      },*/
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(dateController == null
                          ? 'No Date Chosen!'
                          : DateFormat.yMd().format(dateController)),
                    ),
                    Platform.isIOS ?  CupertinoButton(
                      child: Text(
                        'choose Date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onPressed: presentDatePicker,

                    ) :  FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      child: Text(
                        'choose Date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onPressed: presentDatePicker,
                    )
                  ],
                ),
              ),
              RaisedButton(
                child: Text('Add Transaction'),
                textColor: Theme.of(context).textTheme.button.color,
                color: Theme.of(context).primaryColor,
                onPressed: submitData,
              )
            ],
          ),
        ),
      ),
    );
  }
}
