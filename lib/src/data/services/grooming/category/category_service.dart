// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'package:allnimall_web/src/data/services/grooming/category/category_service_state.dart';
import 'package:allnimall_web/src/data/usecases/service/fetch_pet_categories.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_service.g.dart';

@riverpod
class CategoryService extends _$CategoryService {
  late FetchPetCategories _fetchPetCategories;

  @override
  CategoryServiceState build() {
    _fetchPetCategories = ref.watch(fetchPetCategoriesProvider);
    return CategoryServiceState.initial();
  }

  Future<void> fetchPetCategory() async {
    state = CategoryServiceState.loading();

    final result = await _fetchPetCategories();
    result.fold(
      (failure) {
        state = CategoryServiceState.error(failure.message);
      },
      (categories) {
        state = CategoryServiceState.success(categories);
      },
    );
  }
}
