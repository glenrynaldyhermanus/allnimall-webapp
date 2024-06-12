import 'package:allnimall_web/src/data/models/pet_category.dart';

abstract class CategoryState {
  const CategoryState();
}

class ServiceCategoryInitialState extends CategoryState {}

class ServiceCategoryLoadingState extends CategoryState {}

class PetCategoryFetchedState extends CategoryState {
  const PetCategoryFetchedState(this.categoryList);

  final List<PetCategory> categoryList;
}

class ServiceCategoryUnauthenticatedState extends CategoryState {}

class ServiceCategoryErrorState extends CategoryState {
  const ServiceCategoryErrorState(this.message);

  final String message;
}
