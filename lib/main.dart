import 'package:expenses_app/widgets/chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(MyApp());
}

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
      title: 'test10',
      date: DateTime.now(),
    ),
    Transaction(
      id: '1',
      amount: 100,
      title: 'test10',
      date: DateTime.now(),
    ),
    Transaction(
      id: '1',
      amount: 100,
      title: 'test10',
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

  void deleteTransaction(String id) {
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

  bool _showChart = false;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final _isLandscape =
        mediaQuery.orientation == Orientation.landscape;

    final appbar = AppBar(
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
    );

    final transactionsWidget = Container(
      child: TransactionList(_transactions, deleteTransaction),
      height: (mediaQuery.size.height -
              appbar.preferredSize.height -
              mediaQuery.padding.top) *
          0.8,
    );

    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            if (_isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Show Chart'),
                  Switch(
                    value: _showChart,
                    onChanged: (value) {
                      setState(() {
                        _showChart = value;
                      });
                    },
                  ),
                ],
              ),
            if (!_isLandscape)
              Container(
                child: Chart(lastWeekTransactions),
                height: (mediaQuery.size.height -
                        appbar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.2,
              ),
            if (!_isLandscape) transactionsWidget,
            if (_isLandscape)
              _showChart
                  ? Container(
                      child: Chart(lastWeekTransactions),
                      height: (mediaQuery.size.height -
                              appbar.preferredSize.height -
                              mediaQuery.padding.top) *
                          0.7,
                    )
                  : transactionsWidget,
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
