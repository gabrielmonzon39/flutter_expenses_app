import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction(this.addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime date;

  void submitData() {
    final title = titleController.text;
    final amount = double.parse(amountController.text);

    if (title.isEmpty || amount <= 0 || date == null) {
      return;
    }
    widget.addTransaction(
      titleController.text,
      double.parse(amountController.text),
      date,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value != null) {
        setState(() {
          date = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Flexible(
                    fit: FlexFit.tight,
                    child: Text(
                      date == null
                          ? 'No Date Chosen!'
                          : 'Picked Date: ' + DateFormat.yMd().format(date),
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  FlatButton(
                    textColor: Theme.of(context)
                        .floatingActionButtonTheme
                        .backgroundColor,
                    onPressed: _presentDatePicker,
                    child: Text('Choose date'),
                  )
                ],
              ),
            ),
            RaisedButton(
              color:
                  Theme.of(context).floatingActionButtonTheme.backgroundColor,
              onPressed: submitData,
              child: Text('Add Transaction'),
              textColor: Colors.white,
            ),
          ],
        ),
      ),
      elevation: 10,
    );
  }
}
