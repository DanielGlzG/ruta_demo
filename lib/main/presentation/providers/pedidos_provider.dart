import 'package:ruta_demo/main/domain/entities/entities.dart';
import 'package:ruta_demo/main/domain/repositories/combined_repository.dart';
import 'package:ruta_demo/main/presentation/providers/repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pedidosProvider =
    StateNotifierProvider<PedidosNotifier, PedidosState>((ref) {
  final pedidosRepository = ref.watch(mixRepositoryProvider);

  return PedidosNotifier(pedidosRepository: pedidosRepository);
});

class PedidosNotifier extends StateNotifier<PedidosState> {
  final CombinedRepository pedidosRepository;

  PedidosNotifier({required this.pedidosRepository}) : super(PedidosState()) {
    loadPedidos();
  }

  Future loadPedidos() async {
    final pedidos = await pedidosRepository.getPedidos();

    state = state.copyWith(pedidos: pedidos);
  }

  Future guardarPedido(Pedido pedido) async {
    await pedidosRepository.savePedido(pedido);

    state = state.copyWith(
      pedidos: [...state.pedidos, pedido],
    );
  }

  Future enviarPedido(Pedido pedido) async {
    await pedidosRepository.enviarPedido(pedido);

    final updatedPedidos =
        state.pedidos.where((p) => p.doctoVeId != pedido.doctoVeId).toList();

    state = state.copyWith(pedidos: updatedPedidos);
  }

  Future enviarPedidos(List<Pedido> pedidos) async {
    List<Pedido> updatedPedidos = state.pedidos;
    for (final pedido in pedidos) {
      await pedidosRepository.enviarPedido(pedido);

      updatedPedidos =
          state.pedidos.where((p) => p.doctoVeId != pedido.doctoVeId).toList();
    }

    state = state.copyWith(pedidos: updatedPedidos);
  }
}

class PedidosState {
  final List<Pedido> pedidos;

  PedidosState({this.pedidos = const []});

  PedidosState copyWith({List<Pedido>? pedidos}) =>
      PedidosState(pedidos: pedidos ?? this.pedidos);
}
