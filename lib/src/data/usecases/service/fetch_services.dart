import 'package:allnimall_web/src/core/injections/application_module.dart';
import 'package:allnimall_web/src/core/loggers/logger.dart';
import 'package:allnimall_web/src/core/utils/errors/failures.dart';
import 'package:allnimall_web/src/core/utils/typedefs.dart';
import 'package:allnimall_web/src/core/utils/usecase.dart';
import 'package:allnimall_web/src/data/models/service.dart';
import 'package:allnimall_web/src/data/models/service_add_on.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fetch_services.g.dart';

class FetchServices
    extends UsecaseWithParams<List<ServiceModel>, FetchServicesParams> {
  const FetchServices(this.firestore);

  final FirebaseFirestore firestore;

  @override
  ResultFuture<List<ServiceModel>> call(FetchServicesParams params) async {
    try {
      final docRef = firestore.doc('service_categories/${params.categoryUid}');

      final queryService = await firestore
          .collection("services")
          .where('category_uid', isEqualTo: docRef)
          .orderBy('sequence', descending: false)
          .get();

      final List<ServiceModel> data = queryService.docs
          .map((doc) => ServiceModel.fromSnapshot(doc))
          .toList();

      for (ServiceModel service in data) {
        final queryAddOn = await firestore
            .collection('services')
            .doc(service.id)
            .collection('add_ons')
            .orderBy('sequence', descending: false)
            .get();

        final List<ServiceAddOnModel> dataAddOn = queryAddOn.docs
            .map((doc) => ServiceAddOnModel.fromSnapshot(doc))
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

class FetchServicesParams {
  const FetchServicesParams({
    required this.categoryUid,
  });

  const FetchServicesParams.empty() : this(categoryUid: '');

  final String categoryUid;
}

@riverpod
FetchServices fetchServices(FetchServicesRef ref) {
  final firestore = ref.watch(firebaseFirestoreProvider);
  return FetchServices(firestore);
}
