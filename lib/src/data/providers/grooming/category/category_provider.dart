import 'package:allnimall_web/src/data/providers/grooming/category/category_provider_state.dart';
import 'package:allnimall_web/src/data/usecases/service/fetch_pet_categories.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_provider.g.dart';

@riverpod
class Category extends _$Category {
  Category();

  late final FetchPetCategories _fetchPetCategories;

  void init(FetchPetCategories fetchPetCategories) {
    _fetchPetCategories = fetchPetCategories;
  }

  @override
  CategoryProviderState build() {
    return CategoryProviderState.initial();
  }

  Future<void> fetchPetCategory() async {
    state = CategoryProviderState.loading();

    final result = await _fetchPetCategories();
    result.fold(
      (failure) {
        state = CategoryProviderState.error();
      },
      (categories) {
        state = CategoryProviderState.success(categories);
      },
    );
  }
}
