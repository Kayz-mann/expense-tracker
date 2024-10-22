import 'package:expense_repository/expense_repository.dart';
import 'package:expense_tracker/screens/add_expense/blocs/bloc/create_expense_bloc/create_expense_bloc.dart';
import 'package:expense_tracker/screens/add_expense/blocs/bloc/get_categories_bloc/get_categories_bloc_bloc.dart';
import 'package:expense_tracker/screens/add_expense/views/category_creation.dart';
import 'package:expense_tracker/screens/add_expense/widget/app_button.dart';
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
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.background,
          ),
          body: BlocBuilder<GetCategoriesBloc, GetCategoriesBlocState>(
            builder: (context, state) {
              if (state is GetCategoriesSuccess) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Add Expenses",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: TextFormField(
                          controller: expenseController,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: const Icon(
                              FontAwesomeIcons.dollarSign,
                              size: 16,
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      TextFormField(
                        controller: categoryController,
                        textAlignVertical: TextAlignVertical.center,
                        readOnly: true,
                        onTap: () {},
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
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
                          suffixIcon: IconButton(
                            onPressed: () async {
                              var test = await getCategoryCreation(context);
                              print(test);
                            },
                            icon: const Icon(
                              FontAwesomeIcons.plus,
                              size: 16,
                              color: Colors.grey,
                            ),
                          ),
                          hintText: 'Category',
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(12)),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            itemCount: state.categories.length,
                            itemBuilder: (context, int i) {
                              return Card(
                                child: ListTile(
                                  onTap: () {
                                    setState(() {
                                      expense.category = state.categories[i];
                                      categoryController.text =
                                          expense.category.name;
                                    });
                                  },
                                  leading: Image.asset(
                                    'assets/${state.categories[i].icon}.png',
                                    scale: 2,
                                  ),
                                  title: Text(state.categories[i].name),
                                  tileColor: Color(state.categories[i].color),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: dateController,
                        textAlignVertical: TextAlignVertical.center,
                        readOnly: true,
                        onTap: () async {
                          DateTime? newDate = await showDatePicker(
                            context: context,
                            initialDate: expense.date,
                            firstDate: DateTime.now(),
                            lastDate:
                                DateTime.now().add(const Duration(days: 365)),
                          );
                          if (newDate != null) {
                            setState(() {
                              dateController.text =
                                  DateFormat('dd/MM/yyyy').format(newDate);
                              expense.date = newDate;
                            });
                          }
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: const Icon(
                            FontAwesomeIcons.clock,
                            size: 16,
                            color: Colors.grey,
                          ),
                          hintText: 'Date',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
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
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
