// ignore_for_file: prefer_const_constructors
import 'package:expense_repository/expense_repository.dart';
import 'package:expense_tracker/screens/add_expense/blocs/bloc/create_expense_bloc/create_expense_bloc.dart';
import 'package:expense_tracker/screens/add_expense/blocs/bloc/get_categories_bloc/get_categories_bloc_bloc.dart';
import 'package:expense_tracker/screens/add_expense/blocs/bloc/get_expenses_bloc/get_expenses_bloc.dart';
import 'package:expense_tracker/screens/add_expense/blocs/create_category_bloc/create_category_bloc.dart';
import 'package:expense_tracker/screens/home/views/view_transactions.dart';
import 'package:expense_tracker/screens/home/widget/app_list.dart';
import 'package:expense_tracker/screens/home/widget/home_header.dart';
import 'package:expense_tracker/screens/home/widget/wallet_balance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            ),
          ),
          const SizedBox(height: 20),

          // Using BlocBuilder to listen to GetExpensesBloc for total expenses
          BlocBuilder<GetExpensesBloc, GetExpensesState>(
            builder: (context, state) {
              if (state is GetExpensesLoading) {
                return WalletBalance(
                  totalBalance: '\$4800.00',
                  income: '\$2500.00',
                  expenses: '\$0.00', // Show 0 while loading
                );
              } else if (state is GetExpensesSuccess) {
                // Calculate total expenses
                int totalExpenses = state.expenses
                    .fold(0, (sum, expense) => sum + expense.amount);

                return WalletBalance(
                  totalBalance: '\$4800.00',
                  income: '\$2500.00',
                  expenses:
                      '\$${totalExpenses}.00', // Display calculated total expenses
                );
              } else {
                return WalletBalance(
                  totalBalance: '\$4800.00',
                  income: '\$2500.00',
                  expenses: '\$0.00', // Default if no expenses loaded
                );
              }
            },
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
                onTap: () async {
                  Expense? newExpense = await Navigator.push<Expense>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MultiBlocProvider(
                        providers: [
                          BlocProvider(
                            create: (context) =>
                                CreateCategoryBloc(FirebaseExpenseRepo()),
                          ),
                          BlocProvider(
                            create: (context) =>
                                GetCategoriesBloc(FirebaseExpenseRepo())
                                  ..add(GetCategories()),
                          ),
                          BlocProvider(
                            create: (context) =>
                                CreateExpenseBloc(FirebaseExpenseRepo()),
                          ),
                          BlocProvider(
                            create: (context) =>
                                GetExpensesBloc(FirebaseExpenseRepo())
                                  ..add(GetExpenses()),
                          ),
                        ],
                        child:
                            ViewTransactions(), // Ensure AddExpense is correctly loaded
                      ),
                    ),
                  );
                },
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
          Expanded(child: AppListView()),
        ],
      ),
    );
  }
}
