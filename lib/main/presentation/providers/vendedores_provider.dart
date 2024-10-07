import 'package:ruta_demo/main/domain/entities/vendedor.dart';
import 'package:ruta_demo/main/domain/repositories/combined_repository.dart';
import 'package:ruta_demo/main/presentation/providers/repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final vendedoresProvider =
    StateNotifierProvider<VendedoresNotifier, VendedoresState>((ref) {
  final vendedoresRepository = ref.watch(mixRepositoryProvider);

  return VendedoresNotifier(repository: vendedoresRepository);
});

class VendedoresNotifier extends StateNotifier<VendedoresState> {
  final CombinedRepository repository;

  VendedoresNotifier({required this.repository}) : super(VendedoresState()) {
    loadVendedores();
  }

  Future loadVendedores() async {
    final vendedores = await repository.getVendedores();

    state = state.copyWith(vendedores: vendedores);
  }
}

class VendedoresState {
  final List<Vendedor> vendedores;

  VendedoresState({this.vendedores = const []});

  VendedoresState copyWith({List<Vendedor>? vendedores}) =>
      VendedoresState(vendedores: vendedores ?? this.vendedores);
}
