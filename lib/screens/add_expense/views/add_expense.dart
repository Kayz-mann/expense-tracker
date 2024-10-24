import 'package:expense_repository/expense_repository.dart';
import 'package:expense_tracker/screens/add_expense/blocs/bloc/create_expense_bloc/create_expense_bloc.dart';
import 'package:expense_tracker/screens/add_expense/blocs/bloc/get_categories_bloc/get_categories_bloc_bloc.dart';
import 'package:expense_tracker/screens/add_expense/widget/categories_list.dart';
import 'package:expense_tracker/screens/add_expense/widget/category_creation.dart';
import 'package:expense_tracker/screens/add_expense/widget/app_button.dart';
import 'package:expense_tracker/screens/add_expense/widget/category_picker.dart';
import 'package:expense_tracker/screens/add_expense/widget/date_picker_field.dart';
import 'package:expense_tracker/screens/add_expense/widget/expense_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class AddExpense extends StatefulWidget {
  late final Expense newExpense;

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  TextEditingController expenseController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  bool isLoading = false;
  late Expense expense;

  @override
  void initState() {
    dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    expense = Expense.empty;
    expense.expenseId = const Uuid().v1();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateExpenseBloc, CreateExpenseState>(
      listener: (context, state) {
        if (state is CreateExpenseSuccess) {
          Navigator.pop(context);
        } else if (state is CreateExpenseLoading) {
          setState(() {
            isLoading = true;
          });
        }
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surface,
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.surface,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Add Expenses",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: ExpenseInputField(controller: expenseController)),
                  const SizedBox(height: 32),
                  CategoryPicker(
                      controller: categoryController,
                      prefixIcon: expense.category == Category.empty
                          ? const Icon(
                              FontAwesomeIcons.list,
                              size: 16,
                              color: Colors.grey,
                            )
                          : Image.asset(
                              'assets/${expense.category.icon}.png',
                              scale: 2,
                            ),
                      onPressed: () async {
                        var test = await getCategoryCreation(context);
                        print(test);
                      }),
                  CategoriesList(
                    onCategorySelected: (category) {
                      setState(() {
                        expense.category = category;
                        categoryController.text = category.name;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  DatePickerField(
                    controller: dateController,
                    initialDate: expense.date,
                    onDateChanged: (newDate) async {
                      DateTime? newDate = await showDatePicker(
                        context: context,
                        initialDate: expense.date,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (newDate != null) {
                        setState(() {
                          dateController.text =
                              DateFormat('dd/MM/yyyy').format(newDate);
                          expense.date = newDate;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 32),
                  AppButton(
                    isLoading: isLoading,
                    label: 'Save',
                    onPressed: () {
                      setState(() {
                        expense.amount = int.parse(expenseController.text);
                        context
                            .read<CreateExpenseBloc>()
                            .add(CreateExpense(expense));
                      });
                    },
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
