import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test_project/chart.dart';
import 'package:test_project/constants.dart';
import 'package:test_project/new_transaction.dart';
import 'package:test_project/transaction.dart';
import 'package:test_project/transaction_list.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        brightness: Brightness.dark,
        // useMaterial3: true,
        // fontFamily: 'Quicksand',
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool showChart = false;

  final List<Transaction> _userTransactions = [];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date!.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTx(String txTitle, double txAmount, DateTime txDate) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: txDate,
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        context: ctx,
        builder: (_) {
          return NewTransaction(_addNewTx);
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  final appBar = AppBar(
    titleTextStyle: const TextStyle(
      fontSize: 25,
    ),
    title: const Text('Personal Expenses'),
  );

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: isLandscape
            ? Column(
                children: [
                  const Text('Show chart'),
                  Switch.adaptive(
                    value: showChart,
                    onChanged: ((value) {
                      setState(() {
                        showChart = value;
                      });
                    }),
                  ),
                  showChart
                      ? Expanded(
                          child: Center(child: Chart(_recentTransactions)))
                      : Expanded(
                          child: Center(
                          child: TransactionList(
                              _userTransactions, _deleteTransaction),
                        )),
                ],
              )
            : Column(
                children: [
                  Center(
                    child: SizedBox(
                      height: (mediaQuery.size.height -
                              appBar.preferredSize.height -
                              mediaQuery.padding.top) *
                          0.33,
                      child: Chart(_recentTransactions),
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      height: (mediaQuery.size.height -
                              appBar.preferredSize.height -
                              mediaQuery.padding.top) *
                          0.66,
                      child: TransactionList(
                          _userTransactions, _deleteTransaction),
                    ),
                  ),
                ],
              ),
      ),
      floatingActionButton: Platform.isIOS
          ? Container()
          : FloatingActionButton(
              backgroundColor: accentColor,
              onPressed: () => _startAddNewTransaction(context),
              child: const Icon(Icons.add),
            ),
    );
  }
}
