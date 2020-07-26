import 'package:expenses_app/widgets/chart.dart';
import 'package:flutter/material.dart';

import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  ThemeData theme = ThemeData.dark().copyWith(
      floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.red,
  ));

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenses App',
      theme: theme,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // String titleInput;
  // String amountInput;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    Transaction(
      id: '1',
      amount: 100,
      title: 'test1',
      date: DateTime.now(),
    ),
    Transaction(
      id: '1',
      amount: 100,
      title: 'test1',
      date: DateTime.now(),
    ),
    Transaction(
      id: '1',
      amount: 100,
      title: 'test1',
      date: DateTime.now(),
    ),
    Transaction(
      id: '1',
      amount: 100,
      title: 'test1',
      date: DateTime.now(),
    ),
    Transaction(
      id: '1',
      amount: 100,
      title: 'test1',
      date: DateTime.now(),
    ),
    Transaction(
      id: '1',
      amount: 100,
      title: 'test1',
      date: DateTime.now(),
    ),
    Transaction(
      id: '1',
      amount: 100,
      title: 'test1',
      date: DateTime.now(),
    ),
    Transaction(
      id: '1',
      amount: 100,
      title: 'test1',
      date: DateTime.now(),
    ),
    Transaction(
      id: '1',
      amount: 100,
      title: 'test1',
      date: DateTime.now(),
    ),
  ];

  void addNewTransaction(String title, double amount, DateTime date) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: date,
    );

    setState(() {
      _transactions.add(newTx);
    });
  }

  void deleteTransaction(String id){
    setState(() {
      _transactions.removeWhere((element) => element.id == id);
    });
  }

  void startNewTransaction(BuildContext buildContext) {
    showModalBottomSheet(
      context: buildContext,
      builder: (_) {
        return NewTransaction(addNewTransaction);
      },
    );
  }

  List<Transaction> get lastWeekTransactions {
    return _transactions.where((transaction) {
      return transaction.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expenses App'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add_circle,
              color: Colors.red,
            ),
            onPressed: () => startNewTransaction(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Chart(lastWeekTransactions),
            TransactionList(_transactions, deleteTransaction)
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () => startNewTransaction(context),
      ),
    );
  }
}
