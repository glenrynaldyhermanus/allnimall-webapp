import 'package:allnimall_web/src/core/injections/application_module.dart';
import 'package:allnimall_web/src/core/loggers/logger.dart';
import 'package:allnimall_web/src/core/utils/errors/failures.dart';
import 'package:allnimall_web/src/core/utils/typedefs.dart';
import 'package:allnimall_web/src/core/utils/usecase.dart';
import 'package:allnimall_web/src/data/models/pet_category.dart';
import 'package:allnimall_web/src/data/models/service_category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fetch_pet_categories.g.dart';

class FetchPetCategories extends UsecaseWithoutParams<List<PetCategoryModel>> {
  const FetchPetCategories(this.firestore);

  final FirebaseFirestore firestore;

  @override
  ResultFuture<List<PetCategoryModel>> call() async {
    try {
      final query = await firestore
          .collection("pet_categories")
          .where("is_active", isEqualTo: true)
          .get();

      final List<PetCategoryModel> data =
          query.docs.map((doc) => PetCategoryModel.fromSnapshot(doc)).toList();

      for (PetCategoryModel category in data) {
        final queryService = await firestore
            .collection("service_categories")
            .where('group_sequence', isEqualTo: category.sequence)
            .where('is_active', isEqualTo: true)
            .get();

        final List<ServiceCategoryModel> services = queryService.docs
            .map((serviceDoc) => ServiceCategoryModel.fromSnapshot(serviceDoc))
            .toList();

        category.services = services;
      }

      return Right(data);
    } catch (e) {
      logger.e(e);
      return Left(ServerFailure(
          message: "Oops layanan kami sedang bermasalah, mohon coba lagi",
          statusCode: 500));
    }
  }
}

@riverpod
FetchPetCategories fetchPetCategories(FetchPetCategoriesRef ref) {
  final firestore = ref.watch(firebaseFirestoreProvider);
  return FetchPetCategories(firestore);
}
