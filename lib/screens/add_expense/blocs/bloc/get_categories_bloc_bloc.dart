import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'get_categories_bloc_event.dart';
part 'get_categories_bloc_state.dart';

class GetCategoriesBlocBloc extends Bloc<GetCategoriesBlocEvent, GetCategoriesBlocState> {
  GetCategoriesBlocBloc() : super(GetCategoriesBlocInitial()) {
    on<GetCategoriesBlocEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
