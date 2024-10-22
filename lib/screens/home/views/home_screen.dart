import 'dart:math';
import 'package:expense_repository/expense_repository.dart';
import 'package:expense_tracker/screens/add_expense/blocs/bloc/create_expense_bloc/create_expense_bloc.dart';
import 'package:expense_tracker/screens/add_expense/blocs/bloc/get_categories_bloc/get_categories_bloc_bloc.dart';
import 'package:expense_tracker/screens/add_expense/blocs/bloc/get_expenses_bloc/get_expenses_bloc.dart';
import 'package:expense_tracker/screens/add_expense/blocs/create_category_bloc/create_category_bloc.dart';
import 'package:expense_tracker/screens/add_expense/views/add_expense.dart';
import 'package:expense_tracker/screens/home/views/main_screen.dart';
import 'package:expense_tracker/screens/stats/stats.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // Variable to keep track of the selected index

  // Function to handle BottomNavigationBar item tap
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 3,
          currentIndex: _selectedIndex, // Highlight the selected item
          selectedItemColor:
              Theme.of(context).colorScheme.primary, // Selected item color
          unselectedItemColor: Colors.grey, // Unselected item color
          onTap: _onItemTapped, // Call the function when an item is tapped
          items: const [
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.graph_square_fill), label: 'Stats'),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Using Navigator.push to open the modal without unnecessary casting
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
                ],
                child: AddExpense(), // Ensure AddExpense is correctly loaded
              ),
            ),
          );

          // Handle the new expense if returned
          if (newExpense != null) {
            setState(() {
              // You can update your expense list here if needed
              // For example, add the newExpense to a list of expenses
            });
          }
        },
        // Use CircleBorder to ensure circular shape
        shape: const CircleBorder(),
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle, // Enforce circular shape
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.secondary,
                Theme.of(context).colorScheme.tertiary,
                Theme.of(context).colorScheme.primary,
              ],
              transform: const GradientRotation(pi / 4),
            ),
          ),
          child: const Icon(CupertinoIcons.add),
        ),
      ),
      body: _selectedIndex == 0
          ? BlocProvider(
              create: (context) =>
                  GetExpensesBloc(FirebaseExpenseRepo())..add(GetExpenses()),
              child: const MainScreen(),
            )
          : const StatScreen(), // Add content based on the selected tab
    );
  }
}
