import 'package:ruta_demo/main/domain/entities/entities.dart';
import 'package:ruta_demo/main/domain/repositories/combined_repository.dart';
import 'package:ruta_demo/main/presentation/providers/repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final condicionesPagoProvider =
    StateNotifierProvider<CondicionesPagoNotifier, CondicionesPagoState>((ref) {
  final condicionesPagoRepository = ref.watch(mixRepositoryProvider);

  return CondicionesPagoNotifier(repository: condicionesPagoRepository);
});

class CondicionesPagoNotifier extends StateNotifier<CondicionesPagoState> {
  final CombinedRepository repository;

  CondicionesPagoNotifier({required this.repository})
      : super(CondicionesPagoState()) {
    loadCondicionesPago();
  }

  Future loadCondicionesPago() async {
    final condicionesPago = await repository.getCondicionesPago();

    state = state.copyWith(condicionesPago: condicionesPago);
  }
}

class CondicionesPagoState {
  final List<CondicionPago> condicionesPago;

  CondicionesPagoState({this.condicionesPago = const []});

  CondicionesPagoState copyWith({List<CondicionPago>? condicionesPago}) =>
      CondicionesPagoState(
          condicionesPago: condicionesPago ?? this.condicionesPago);
}
