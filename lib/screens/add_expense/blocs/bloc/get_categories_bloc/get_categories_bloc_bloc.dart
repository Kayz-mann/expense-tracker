import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_repository/expense_repository.dart';

part 'get_categories_bloc_event.dart';
part 'get_categories_bloc_state.dart';

class GetCategoriesBloc
    extends Bloc<GetCategoriesBlocEvent, GetCategoriesBlocState> {
  final ExpenseRepository expenseRepository;

  GetCategoriesBloc(this.expenseRepository)
      : super(GetCategoriesBlocInitial()) {
    on<GetCategories>((event, emit) async {
      emit(GetCategoriesLoading());
      try {
        List<Category> categories = await expenseRepository.getCategory();
        emit(GetCategoriesSuccess(categories));
      } catch (e) {
        emit(GetCategoriesFailure());
      }
    });
  }
}
