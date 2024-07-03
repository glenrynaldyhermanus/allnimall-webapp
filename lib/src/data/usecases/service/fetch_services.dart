import 'package:allnimall_web/src/core/utils/typedefs.dart';
import 'package:allnimall_web/src/core/utils/usecase.dart';
import 'package:allnimall_web/src/data/models/service.dart';
import 'package:allnimall_web/src/data/repositories/service_repository.dart';

class FetchServices
    extends UsecaseWithParams<List<ServiceModel>, FetchServicesParams> {
  const FetchServices(this._repo);

  final ServiceRepository _repo;

  @override
  ResultFuture<List<ServiceModel>> call(FetchServicesParams params) =>
      _repo.fetchServices(categoryUid: params.categoryUid);
}

class FetchServicesParams {
  const FetchServicesParams({
    required this.categoryUid,
  });

  const FetchServicesParams.empty() : this(categoryUid: '');

  final String categoryUid;
}
