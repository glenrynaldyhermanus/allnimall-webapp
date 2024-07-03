import 'package:allnimall_web/src/core/utils/base_state.dart';
import 'package:allnimall_web/src/data/models/pet_category.dart';

class CategoryProviderState extends BaseState<List<PetCategoryModel>> {
  CategoryProviderState({
    bool isLoading = false,
    bool isError = false,
    List<PetCategoryModel>? data,
    String? message,
  }) : super(
            isLoading: isLoading,
            isError: isError,
            data: data,
            message: message);

  factory CategoryProviderState.initial() {
    return CategoryProviderState();
  }

  factory CategoryProviderState.loading() {
    return CategoryProviderState(isLoading: true);
  }

  factory CategoryProviderState.success(List<PetCategoryModel> data) {
    return CategoryProviderState(data: data);
  }

  factory CategoryProviderState.error(String message) {
    return CategoryProviderState(isError: true, message: message);
  }
}
