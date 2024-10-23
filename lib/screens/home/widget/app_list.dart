import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expense_tracker/screens/add_expense/blocs/bloc/get_expenses_bloc/get_expenses_bloc.dart';
import 'package:intl/intl.dart';

class AppListView extends StatelessWidget {
  const AppListView({Key? key}) : super(key: key); // Remove listData parameter

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetExpensesBloc, GetExpensesState>(
      builder: (context, state) {
        if (state is GetExpensesLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is GetExpensesFailure) {
          return const Center(
            child: Text('Failed to load expenses'),
          );
        }

        if (state is GetExpensesSuccess) {
          final expenses = state.expenses;

          return ListView.builder(
            itemCount: expenses.length,
            itemBuilder: (context, int i) {
              final expense = expenses[i];

              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 4),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 46,
                                height: 46,
                                decoration: BoxDecoration(
                                  color: Color(expense.category
                                      .color), // Update with actual category color
                                  shape: BoxShape.circle,
                                ),
                              ),
                              // FaIcon(
                              //   expense.category.icon
                              //       as IconData?, // Update with actual category icon
                              //   color: Colors.white,
                              //   size: 16,
                              // ),
                              Image.asset(
                                'assets/${expense.category.icon}.png',
                                scale: 2,
                                color: Colors.white,
                              )
                            ],
                          ),
                          const SizedBox(width: 10),
                          Text(
                            expense.category
                                .name, // Update with actual category name
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.onSurface,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '\$${expense.amount}', // Format amount as needed
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.onSurface,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            DateFormat('dd/MM/yyyy').format(expense.date),
                            // expense.date.toString(), // Format date as needed
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.outline,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        } else if (state is GetExpensesInitial) {
          return const Center(
            child: Text("No expenses recorded"),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
