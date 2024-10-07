import 'package:ruta_demo/main/domain/entities/cobrador.dart';
import 'package:ruta_demo/main/domain/repositories/combined_repository.dart';
import 'package:ruta_demo/main/presentation/providers/repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cobradoresProvider =
    StateNotifierProvider<CobradoresNotifier, CobradoresState>((ref) {
  final cobradoresRepository = ref.watch(mixRepositoryProvider);

  return CobradoresNotifier(repository: cobradoresRepository);
});

class CobradoresNotifier extends StateNotifier<CobradoresState> {
  final CombinedRepository repository;

  CobradoresNotifier({required this.repository}) : super(CobradoresState()) {
    loadCobradores();
  }

  Future<void> syncCobradores() async {
    final cobradores = await repository.syncCobradores();

    state = state.copyWith(cobradores: cobradores);
  }

  Future loadCobradores() async {
    final cobradores = await repository.getCobradores();

    state = state.copyWith(cobradores: cobradores);
  }
}

class CobradoresState {
  final List<Cobrador> cobradores;

  CobradoresState({this.cobradores = const []});

  CobradoresState copyWith({List<Cobrador>? cobradores}) =>
      CobradoresState(cobradores: cobradores ?? this.cobradores);
}
