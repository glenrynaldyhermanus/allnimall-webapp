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

  ResultFuture<List<PetCategory>> fetchPetCategories() async {
    try {
      final query = await firestore
          .collection("pet_categories")
          .where("is_active", isEqualTo: true)
          .get();

      final List<PetCategory> data =
          query.docs.map((doc) => PetCategory.fromSnapshot(doc)).toList();

      for (PetCategory category in data) {
        final queryService = await firestore
            .collection("service_categories")
            .where('group_sequence', isEqualTo: category.sequence)
            .where('is_active', isEqualTo: true)
            .get();

        final List<ServiceCategory> services = queryService.docs
            .map((serviceDoc) => ServiceCategory.fromSnapshot(serviceDoc))
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

  ResultFuture<List<Service>> fetchServices(
      {required String categoryUid}) async {
    try {
      final docRef = firestore.doc('service_categories/$categoryUid');

      final queryService = await firestore
          .collection("services")
          .where('category_uid', isEqualTo: docRef)
          .orderBy('sequence', descending: false)
          .get();

      final List<Service> data =
          queryService.docs.map((doc) => Service.fromSnapshot(doc)).toList();

      for (Service service in data) {
        final queryAddOn = await firestore
            .collection('services')
            .doc(service.id)
            .collection('add_ons')
            .orderBy('sequence', descending: false)
            .get();

        final List<ServiceAddOn> dataAddOn = queryAddOn.docs
            .map((doc) => ServiceAddOn.fromSnapshot(doc))
            .toList();
        service.addOns = dataAddOn;
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
