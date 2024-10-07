import 'package:ruta_demo/main/domain/entities/cliente.dart';
import 'package:ruta_demo/main/domain/repositories/combined_repository.dart';
import 'package:ruta_demo/main/presentation/providers/repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final clientesProvider =
    StateNotifierProvider<ClientesNotifier, ClientesState>((ref) {
  final clientesRepository = ref.watch(mixRepositoryProvider);

  return ClientesNotifier(repository: clientesRepository);
});

class ClientesNotifier extends StateNotifier<ClientesState> {
  final CombinedRepository repository;

  ClientesNotifier({required this.repository}) : super(ClientesState()) {
    loadClientes();
  }

  Future<void> syncClientes() async {
    final clientes = await repository.syncClientes();

    state = state.copyWith(clientes: clientes);
  }

  Future<void> loadClientes() async {
    if (state.isLoading || state.isLastPage) return;

    state = state.copyWith(isLoading: true);

    try {
      final clientes = await repository.getClientesByPage(
          size: state.size, page: state.page);

      if (clientes.isEmpty) {
        state = state.copyWith(isLastPage: true, isLoading: false);
      } else {
        state = state.copyWith(
          isLastPage: false,
          isLoading: false,
          clientes: [...state.clientes, ...clientes],
          page: state.page + 1,
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

class ClientesState {
  final bool isLastPage;
  final int size;
  final int page;
  final bool isLoading;
  final List<Cliente> clientes;
  final String? error;

  ClientesState({
    this.isLastPage = false,
    this.size = 10,
    this.page = 0,
    this.isLoading = false,
    this.clientes = const [],
    this.error,
  });

  ClientesState copyWith({
    bool? isLastPage,
    int? size,
    int? page,
    bool? isLoading,
    List<Cliente>? clientes,
    String? error,
  }) =>
      ClientesState(
        isLastPage: isLastPage ?? this.isLastPage,
        size: size ?? this.size,
        page: page ?? this.page,
        isLoading: isLoading ?? this.isLoading,
        clientes: clientes ?? this.clientes,
        error: error ?? this.error,
      );
}
