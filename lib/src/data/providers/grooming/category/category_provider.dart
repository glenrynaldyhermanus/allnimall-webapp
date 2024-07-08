// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'package:allnimall_web/src/data/providers/grooming/category/category_provider_state.dart';
import 'package:allnimall_web/src/data/usecases/service/fetch_pet_categories.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_provider.g.dart';

@riverpod
class Category extends _$Category {
  late FetchPetCategories _fetchPetCategories;

  @override
  CategoryProviderState build() {
    _fetchPetCategories = ref.watch(fetchPetCategoriesProvider);
    return CategoryProviderState.initial();
  }

  Future<void> fetchPetCategory() async {
    state = CategoryProviderState.loading();

    final result = await _fetchPetCategories();
    result.fold(
      (failure) {
        state = CategoryProviderState.error(failure.message);
      },
      (categories) {
        state = CategoryProviderState.success(categories);
      },
    );
  }
}
