import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_project/constants.dart';

import 'transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  const TransactionList(this.transactions, this.deleteTx, {super.key});

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Column(
            children: [
              Expanded(
                flex: 7,
                child: Image.asset('images/nothing.png'),
              ),
              const Expanded(
                flex: 2,
                child: Text(
                  'Nothing to see here, try to add new transaction!',
                  style: bodyTextStyle,
                ),
              ),
            ],
          )
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 10,
                margin: const EdgeInsets.all(8),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: accentColor,
                      child: Padding(
                        padding: const EdgeInsets.all(7),
                        child: FittedBox(
                          child: Text(
                            (transactions[index].amount)!.toStringAsFixed(2),
                            style: const TextStyle(),
                          ),
                        ),
                      ),
                    ),
                    title: Text(transactions[index].title!),
                    subtitle: Text(
                      DateFormat.yMMMEd().format(transactions[index].date!),
                    ),
                    trailing: MediaQuery.of(context).size.width > 350
                        ? TextButton.icon(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.red,
                            ),
                            icon: const Icon(Icons.delete),
                            label: const Text('Delete'),
                            onPressed: () => deleteTx(transactions[index].id),
                          )
                        : IconButton(
                            color: Colors.red,
                            onPressed: () => deleteTx(transactions[index].id),
                            icon: const Icon(Icons.delete),
                          ),
                  ),
                ),
              );
            },
          );
  }
}
