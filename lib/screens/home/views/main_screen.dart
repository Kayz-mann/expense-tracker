// ignore_for_file: prefer_const_constructors

import 'package:expense_tracker/data/data.dart';
import 'package:expense_tracker/screens/home/widget/app_list.dart';
import 'package:expense_tracker/screens/home/widget/home_header.dart';
import 'package:expense_tracker/screens/home/widget/wallet_balance.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          // Adjusted SafeArea to avoid excess space
          SafeArea(
              child: HomeHeader(
            username: "John Doe",
          )),
          const SizedBox(height: 20),

          WalletBalance(
            totalBalance: '\$4800.00',
            income: '\$2500.00',
            expenses: '\$800.00',
          ),
          const SizedBox(height: 40),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Transactions',
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'View All',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.outline,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(child: AppListView())
        ],
      ),
    );
  }
}
