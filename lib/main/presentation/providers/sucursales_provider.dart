import 'package:ruta_demo/main/domain/entities/sucursal.dart';
import 'package:ruta_demo/main/domain/repositories/combined_repository.dart';
import 'package:ruta_demo/main/presentation/providers/repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final sucursalesProvider =
    StateNotifierProvider<SucursalesNotifier, SucursalesState>((ref) {
  final sucursalRepository = ref.watch(mixRepositoryProvider);
  return SucursalesNotifier(repository: sucursalRepository);
});

class SucursalesNotifier extends StateNotifier<SucursalesState> {
  final CombinedRepository repository;

  SucursalesNotifier({required this.repository}) : super(SucursalesState()) {
    loadSucursales();
  }

  Future loadSucursales() async {
    final sucursales = await repository.getSucursales();

    state = state.copyWith(sucursales: sucursales);
  }
}

class SucursalesState {
  final List<Sucursal> sucursales;

  SucursalesState({this.sucursales = const []});

  SucursalesState copyWith({List<Sucursal>? sucursales}) =>
      SucursalesState(sucursales: sucursales ?? this.sucursales);
}
