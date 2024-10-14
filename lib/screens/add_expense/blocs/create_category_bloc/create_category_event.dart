// create_category_event.dart
part of 'create_category_bloc.dart'; // Make sure this matches the main file

sealed class CreateCategoryEvent extends Equatable {
  late Category category;

  // const CreateCategoryEvent();

  @override
  List<Object> get props => [];
}

class CreateCategory extends CreateCategoryEvent {
  final Category category;

  CreateCategory(this.category);

  @override
  List<Object> get props => [category];
}
