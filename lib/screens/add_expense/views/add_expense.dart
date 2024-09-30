import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  TextEditingController expenseController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  DateTime selectDate = DateTime.now();

  @override
  void initState() {
    dateController.text = DateFormat('dd/MM/yyy').format(DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          title: const Text(
            'Add Expense',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0), // Corrected the padding issue
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Add Expenses",
                style: TextStyle(
                  // Corrected the TextStyle syntax
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(
                height: 10,
              ),

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
                          borderSide: BorderSide.none)),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                readOnly: true,
                onTap: () {},
                controller: categoryController,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(
                      FontAwesomeIcons.list,
                      size: 16,
                      color: Colors.grey,
                    ),
                    suffixIcon: IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (ctx) {
                                return AlertDialog(
                                  title: const Text('Create a new category'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextFormField(
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        decoration: InputDecoration(
                                            filled: true,
                                            isDense: true,
                                            fillColor: Colors.white,
                                            prefixIcon: const Icon(
                                              FontAwesomeIcons.clock,
                                              size: 16,
                                              color: Colors.grey,
                                            ),
                                            hintText: "Name",
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                borderSide: BorderSide.none)),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      TextFormField(
                                        readOnly: true,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        decoration: const InputDecoration(
                                            filled: true,
                                            isDense: true,
                                            fillColor: Colors.white,
                                            suffixIcon: const Icon(
                                              CupertinoIcons.chevron_down,
                                              size: 16,
                                              color: Colors.grey,
                                            ),
                                            hintText: "Icon",
                                            border: OutlineInputBorder(
                                                borderRadius: const BorderRadius
                                                    .vertical(
                                                    top: Radius.circular(12)),
                                                borderSide: BorderSide.none)),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 200,
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.vertical(
                                                bottom: Radius.circular(12))),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      TextFormField(
                                        readOnly: true,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        decoration: InputDecoration(
                                            filled: true,
                                            isDense: true,
                                            fillColor: Colors.white,
                                            prefixIcon: const Icon(
                                              FontAwesomeIcons.clock,
                                              size: 16,
                                              color: Colors.grey,
                                            ),
                                            hintText: "Color",
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                borderSide: BorderSide.none)),
                                      ),
                                    ],
                                  ),
                                );
                              });
                        },
                        icon: const Icon(
                          FontAwesomeIcons.plus,
                          size: 16,
                          color: Colors.grey,
                        )),
                    hintText: "Category",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none)),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: dateController,
                readOnly: true,
                textAlignVertical: TextAlignVertical.center,
                onTap: () async {
                  DateTime? newDate = await showDatePicker(
                      context: context,
                      initialDate: selectDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(Duration(days: 365)));

                  if (newDate != null) {
                    setState(() {
                      dateController.text =
                          DateFormat('dd/MM/yyyy').format(newDate);
                      selectDate = newDate;
                    });
                  }
                },
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(
                      FontAwesomeIcons.clock,
                      size: 16,
                      color: Colors.grey,
                    ),
                    hintText: "Date",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none)),
              ),
              const SizedBox(
                height: 42,
              ),
              SizedBox(
                width: double.infinity,
                height: kToolbarHeight,
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Save',
                      style: TextStyle(fontSize: 22, color: Colors.white)),
                ),
              )

              // Add more content here as needed
            ],
          ),
        ),
      ),
    );
  }
}
