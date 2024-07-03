import 'package:allnimall_web/src/core/utils/typedefs.dart';
import 'package:allnimall_web/src/core/utils/usecase.dart';
import 'package:allnimall_web/src/data/models/pet_category.dart';
import 'package:allnimall_web/src/data/repositories/service_repository.dart';

class FetchPetCategories extends UsecaseWithoutParams<List<PetCategoryModel>> {
  const FetchPetCategories(this._repo);

  final ServiceRepository _repo;

  @override
  ResultFuture<List<PetCategoryModel>> call() => _repo.fetchPetCategories();
}
