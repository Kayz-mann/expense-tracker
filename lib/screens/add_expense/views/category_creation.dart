import 'package:expense_repository/expense_repository.dart';
import 'package:expense_tracker/screens/add_expense/blocs/create_category_bloc/create_category_bloc.dart';
import 'package:expense_tracker/screens/add_expense/widget/app_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:uuid/uuid.dart';

Future getCategoryCreation(BuildContext context) {
  List<String> myCategoriesIcons = [
    "entertainment",
    "food",
    "home",
    "pet",
    "shopping",
    "tech",
    "travel"
  ];

  return showDialog(
      context: context,
      builder: (ctx) {
        bool isExpanded = false;
        String iconSelected = "";
        Color categoryColor = Colors.white;

        TextEditingController categoryNameController = TextEditingController();
        TextEditingController categoryIconController = TextEditingController();
        TextEditingController categoryColorController = TextEditingController();
        bool isLoading = false;
        Category category = Category.empty;

        return BlocProvider.value(
            value: context.read<CreateCategoryBloc>(),
            child: StatefulBuilder(builder: (ctx, setState) {
              return BlocListener<CreateCategoryBloc, CreateCategoryState>(
                  listener: (context, state) {
                    if (state is CreateCategorySuccess) {
                      Navigator.pop(ctx, "test");
                    } else if (state is CreateCategoryLoading) {
                      setState(() {
                        isLoading = true;
                      });
                    }
                  },
                  child: AlertDialog(
                    title: const Text("Create a new category"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: categoryNameController,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Name',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none)),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: categoryIconController,
                          onTap: () {
                            setState(() {
                              isExpanded = !isExpanded;
                            });
                          },
                          textAlignVertical: TextAlignVertical.center,
                          readOnly: true,
                          decoration: InputDecoration(
                              filled: true,
                              suffixIcon: const Icon(
                                CupertinoIcons.chevron_down,
                                size: 12,
                              ),
                              fillColor: Colors.white,
                              hintText: 'Icon',
                              border: OutlineInputBorder(
                                  borderRadius: isExpanded
                                      ? const BorderRadius.vertical(
                                          top: Radius.circular(12))
                                      : BorderRadius.circular(12),
                                  borderSide: BorderSide.none)),
                        ),
                        isExpanded
                            ? Container(
                                width: MediaQuery.of(context).size.width,
                                height: 200,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.vertical(
                                        bottom: Radius.circular(12))),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3),
                                    itemCount: myCategoriesIcons.length,
                                    itemBuilder: (context, int i) {
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            iconSelected = myCategoriesIcons[i];
                                          });
                                        },
                                        child: Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: iconSelected ==
                                                            myCategoriesIcons[i]
                                                        ? Colors.green
                                                        : Colors.grey),
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/${myCategoriesIcons[i]}.png'),
                                                ))),
                                      );
                                    },
                                  ),
                                ))
                            : Container(),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: categoryColorController,
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (ctx2) {
                                  return AlertDialog(
                                    content: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(
                                            height:
                                                300, // Fixed height for ColorPicker
                                            child: Flexible(
                                              // Set a reasonable height
                                              child: ColorPicker(
                                                pickerColor: Colors.blue,
                                                onColorChanged: (value) {
                                                  setState(() {
                                                    categoryColor = value;
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 16),
                                          AppButton(
                                            label: 'Save Color',
                                            isLoading: isLoading,
                                            onPressed: () {
                                              // Update the color in the main dialog
                                              setState(() {
                                                categoryColorController.text =
                                                    categoryColor.toString();
                                              });
                                              Navigator.pop(
                                                  ctx2); // Close the color picker dialog
                                            },
                                          ) // Add some spacing
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          },
                          textAlignVertical: TextAlignVertical.center,
                          readOnly: true,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: categoryColor,
                              hintText: 'Color',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none)),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        isLoading == true
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : AppButton(
                                label: 'Save',
                                isLoading: isLoading,
                                onPressed: () {
                                  isLoading = true;

                                  print(categoryColor);

                                  setState(() {
                                    category.categoryId = Uuid().v1();
                                    category.name = categoryNameController.text;
                                    category.icon = iconSelected;
                                    category.color = categoryColor.value;
                                  });

                                  context
                                      .read<CreateCategoryBloc>()
                                      .add(CreateCategory(category));
                                  // Close the color picker dialog
                                  Navigator.pop(
                                      ctx); // Close the main category dialog
                                },
                              )
                      ],
                    ),
                  ));
            }));
      });
}
