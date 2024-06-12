import 'package:allnimall_web/src/core/loggers/logger.dart';
import 'package:allnimall_web/src/data/blocs/service/category/category_event.dart';
import 'package:allnimall_web/src/data/blocs/service/category/category_state.dart';
import 'package:allnimall_web/src/data/usecases/service/fetch_pet_categories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  ///Usecases
  final FetchPetCategories _fetchPetCategories;

  ///Bloc
  CategoryBloc({
    required FetchPetCategories fetchPetCategories,
  })  : _fetchPetCategories = fetchPetCategories,
        super(ServiceCategoryInitialState()) {
    on<CategoryEvent>((event, emit) {
      emit(ServiceCategoryLoadingState());
    });
    on<FetchPetCategoryEvent>(_fetchPetCategoriesHandler);
  }

  ///Handler
  Future<void> _fetchPetCategoriesHandler(
    FetchPetCategoryEvent event,
    Emitter<CategoryState> emit,
  ) async {
    emit(ServiceCategoryLoadingState());

    try {
      final result = await _fetchPetCategories();


      result.fold(
        (failure) => emit(ServiceCategoryErrorState(failure.errorMessage)),
        (categoryList) => emit(PetCategoryFetchedState(categoryList)),
      );
    } catch (e) {
      // Handle exceptions if any
      emit(ServiceCategoryErrorState('Error opening store: $e'));
    }
  }
}
