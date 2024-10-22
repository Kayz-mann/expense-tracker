import 'package:expense_tracker/screens/add_expense/blocs/bloc/get_expenses_bloc/get_expenses_bloc.dart';
import 'package:expense_tracker/screens/home/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expense_repository/expense_repository.dart';
// Make sure to import your expense bloc

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Expense Tracker",
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          surface: Colors.grey.shade100,
          onSurface: Colors.black,
          primary: Color(0xFF00B2E7),
          secondary: Color(0xFFE064f7),
          tertiary: Color(0xFFFF8D6C),
          outline: Colors.grey.shade400,
        ),
      ),
      home: BlocProvider(
        create: (context) => GetExpensesBloc(
          context.read<ExpenseRepository>(),
        )..add(GetExpenses()), // Immediately fetch expenses when created
        child: HomeScreen(),
      ),
    );
  }
}
