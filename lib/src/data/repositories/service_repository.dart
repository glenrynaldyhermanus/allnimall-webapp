import 'package:allnimall_web/src/core/loggers/logger.dart';
import 'package:allnimall_web/src/core/utils/errors/failures.dart';
import 'package:allnimall_web/src/core/utils/typedefs.dart';
import 'package:allnimall_web/src/data/models/pet_category.dart';
import 'package:allnimall_web/src/data/models/service.dart';
import 'package:allnimall_web/src/data/models/service_add_on.dart';
import 'package:allnimall_web/src/data/models/service_category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

class ServiceRepository {
  const ServiceRepository({required this.firestore});

  final FirebaseFirestore firestore;

  ResultFuture<List<PetCategoryModel>> fetchPetCategories() async {
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

  ResultFuture<List<ServiceModel>> fetchServices(
      {required String categoryUid}) async {
    try {
      final docRef = firestore.doc('service_categories/$categoryUid');

      final queryService = await firestore
          .collection("services")
          .where('category_uid', isEqualTo: docRef)
          .orderBy('sequence', descending: false)
          .get();

      print('OUT >> 1');

      final List<ServiceModel> data = queryService.docs
          .map((doc) => ServiceModel.fromSnapshot(doc))
          .toList();

      print('OUT >> 2');

      for (ServiceModel service in data) {
        print('OUT >> service ${service.name}');

        print('OUT >> service 1');

        final queryAddOn = await firestore
            .collection('services')
            .doc(service.id)
            .collection('add_ons')
            .orderBy('sequence', descending: false)
            .get();

        print('OUT >> service 2');

        final List<ServiceAddOnModel> dataAddOn = queryAddOn.docs
            .map((doc) => ServiceAddOnModel.fromSnapshot(doc))
            .toList();

        print('OUT >> service 3');
        service.addOns = dataAddOn;
      }

      print('OUT >> 3');

      return Right(data);
    } catch (e) {
      logger.e(e);
      return Left(ServerFailure(
          message: "Oops layanan kami sedang bermasalah, mohon coba lagi",
          statusCode: 500));
    }
  }
}
