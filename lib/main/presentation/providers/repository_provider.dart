import 'package:ruta_demo/main/domain/repositories/microsip_repository.dart';
import 'package:ruta_demo/main/infraestructure/datasources/api_microsip_datasource_impl.dart';
import 'package:ruta_demo/main/infraestructure/datasources/fireStore_datasource.dart';
import 'package:ruta_demo/main/infraestructure/datasources/local_datasource.dart';
import 'package:ruta_demo/main/infraestructure/repositories/api_microsip_repository_impl.dart';
import 'package:ruta_demo/main/infraestructure/repositories/combined_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiMicrosipRepositoryProvider = Provider<MicrosipRepository>((ref) {
  final apiRepository = ApiMicrosipRepositoryImpl(ApiMicrosipDatasourceImpl());

  return apiRepository;
});

final localMicrosipRepositoryProvider = Provider<MicrosipRepository>((ref) {
  final apiRepository = ApiMicrosipRepositoryImpl(FirestoreDatasource());

  return apiRepository;
});

final mixRepositoryProvider = Provider<CombinedRepositoryImpl>((ref) {
  final apiRepository = CombinedRepositoryImpl(
      apiDatasource: ApiMicrosipDatasourceImpl(),
      localDatasource: LocalDatasource());

  return apiRepository;
});
