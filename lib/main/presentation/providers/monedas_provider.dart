import 'package:ruta_demo/main/domain/entities/moneda.dart';
import 'package:ruta_demo/main/domain/repositories/combined_repository.dart';
import 'package:ruta_demo/main/presentation/providers/repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final monedasProvider =
    StateNotifierProvider<MonedasNotifier, MonedasState>((ref) {
  final monedasRepository = ref.watch(mixRepositoryProvider);

  return MonedasNotifier(repository: monedasRepository);
});

class MonedasNotifier extends StateNotifier<MonedasState> {
  final CombinedRepository repository;

  MonedasNotifier({required this.repository}) : super(MonedasState()) {
    loadMonedas();
  }

  Future<void> syncMonedas() async {
    final monedas = await repository.syncMonedas();

    state = state.copyWith(monedas: monedas);
  }

  Future loadMonedas() async {
    final monedas = await repository.getMonedas();

    state = state.copyWith(monedas: monedas);
  }
}

class MonedasState {
  final List<Moneda> monedas;

  MonedasState({this.monedas = const []});

  MonedasState copyWith({List<Moneda>? monedas}) =>
      MonedasState(monedas: monedas ?? this.monedas);
}
