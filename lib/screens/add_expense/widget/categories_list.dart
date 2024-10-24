// categories_list/view/categories_list.dart
import 'package:expense_tracker/screens/add_expense/blocs/bloc/get_categories_bloc/get_categories_bloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expense_repository/expense_repository.dart';

class CategoriesList extends StatelessWidget {
  final Function(Category) onCategorySelected;

  const CategoriesList({
    super.key,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetCategoriesBloc, GetCategoriesBlocState>(
      builder: (context, state) {
        if (state is GetCategoriesLoading) {
          return Container(
            color: Colors.white,
            height: 100,
            width: MediaQuery.of(context).size.width,
            child: const Center(child: CircularProgressIndicator()),
          );
        }

        if (state is GetCategoriesSuccess) {
          return Container(
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
                      onTap: () => onCategorySelected(state.categories[i]),
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
          );
        } else {
          if (state is GetCategoriesFailure) {
            return const Center(child: Text("Cannot find any categoy list"));
          }
        }

        return const SizedBox.shrink();
      },
    );
  }
}
