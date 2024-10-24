import 'package:expense_tracker/screens/home/widget/app_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewTransactions extends StatefulWidget {
  const ViewTransactions({super.key});

  @override
  State<ViewTransactions> createState() => _ViewTransactionsState();
}

class _ViewTransactionsState extends State<ViewTransactions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: const Text("Transaction List"),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [Expanded(child: AppListView())],
        ),
      ),
    );
  }
}


//Theme.of(context).colorScheme.surface