import 'package:ruta_demo/main/domain/entities/almacen.dart';
import 'package:ruta_demo/main/domain/repositories/combined_repository.dart';
import 'package:ruta_demo/main/presentation/providers/repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final almacenesProvider =
    StateNotifierProvider<AlmacenesNotifier, AlamacenesState>((ref) {
  final almacenesRepository = ref.watch(mixRepositoryProvider);

  return AlmacenesNotifier(repository: almacenesRepository);
});

class AlmacenesNotifier extends StateNotifier<AlamacenesState> {
  final CombinedRepository repository;

  AlmacenesNotifier({required this.repository}) : super(AlamacenesState()) {
    loadAlmacenes();
  }

  Future loadAlmacenes() async {
    final almacenes = await repository.getAlmacenes();

    state = state.copyWith(almacenes: almacenes);
  }
}

class AlamacenesState {
  final List<Almacen> almacenes;

  AlamacenesState({this.almacenes = const []});

  AlamacenesState copyWith({List<Almacen>? almacenes}) =>
      AlamacenesState(almacenes: almacenes ?? this.almacenes);
}
