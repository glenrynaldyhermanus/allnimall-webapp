import 'package:allnimall_web/src/core/utils/base_state.dart';
import 'package:allnimall_web/src/data/models/pet_category.dart';

class CategoryServiceState extends BaseState<List<PetCategoryModel>> {
  CategoryServiceState({
    bool isLoading = false,
    bool isError = false,
    List<PetCategoryModel>? data,
    String? message,
  }) : super(
            isLoading: isLoading,
            isError: isError,
            data: data,
            message: message);

  factory CategoryServiceState.initial() {
    return CategoryServiceState();
  }

  factory CategoryServiceState.loading() {
    return CategoryServiceState(isLoading: true);
  }

  factory CategoryServiceState.success(List<PetCategoryModel> data) {
    return CategoryServiceState(data: data);
  }

  factory CategoryServiceState.error(String message) {
    return CategoryServiceState(isError: true, message: message);
  }
}
