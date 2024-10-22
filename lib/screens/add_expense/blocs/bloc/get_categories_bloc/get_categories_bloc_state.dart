part of 'get_categories_bloc_bloc.dart';

sealed class GetCategoriesBlocState extends Equatable {
  const GetCategoriesBlocState();

  @override
  List<Object> get props => [];
}

final class GetCategoriesBlocInitial extends GetCategoriesBlocState {}

final class GetCategoriesFailure extends GetCategoriesBlocState {}

final class GetCategoriesLoading extends GetCategoriesBlocState {}

final class GetCategoriesSuccess extends GetCategoriesBlocState {
  final List<Category> categories;

  const GetCategoriesSuccess(this.categories);

  @override
  List<Object> get props => [categories];
}
