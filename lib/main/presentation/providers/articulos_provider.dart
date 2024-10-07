import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ruta_demo/main/domain/repositories/microsip_repository.dart';
import 'package:ruta_demo/main/infraestructure/mappers/articulo_mapper.dart';
import 'package:ruta_demo/main/presentation/providers/repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ruta_demo/main/domain/entities/articulo.dart';
import 'package:ruta_demo/main/domain/repositories/combined_repository.dart';

// final articulosStreamProvider =
//     StreamProvider.autoDispose<List<Articulo>>((ref) {
//   return FirebaseFirestore.instance
//       .collection('articulos')
//       .snapshots()
//       .map((snapshot) {
//     return snapshot.docs.map((doc) {
//       // Mapea los documentos a la entidad Articulo
//       return ArticuloMapper.jsonToEntity(doc.data());
//     }).toList();
//   });
// });

final articulosProvider =
    StateNotifierProvider<ArticulosNotifier, ArticulosState>((ref) {
  final repository = ref.watch(mixRepositoryProvider);
  return ArticulosNotifier(repository: repository);
});

final articulosFireBaseProvider =
    StateNotifierProvider<ArticulosNotifierFirebase, ArticulosState>((ref) {
  final repository = ref.watch(localMicrosipRepositoryProvider);
  return ArticulosNotifierFirebase(repository: repository);
});

class ArticulosNotifierFirebase extends StateNotifier<ArticulosState> {
  final MicrosipRepository repository;
  StreamSubscription? _articulosSubscription;

  ArticulosNotifierFirebase({required this.repository})
      : super(ArticulosState()) {
    _listenToArticulos();
  }

  // Escucha los cambios en tiempo real desde Firestore
  void _listenToArticulos() {
    _articulosSubscription = FirebaseFirestore.instance
        .collection('articulos')
        .orderBy('articuloId')
        .snapshots()
        .listen((snapshot) {
      final articulos = snapshot.docs.map((doc) {
        return ArticuloMapper.jsonToEntity(doc.data());
      }).toList();

      state = state.copyWith(articulos: articulos, isLoading: false);
    }, onError: (error) {
      state = state.copyWith(error: error.toString(), isLoading: false);
    });
  }

  // Cancela la suscripción al stream de Firestore cuando ya no se necesite
  @override
  void dispose() {
    _articulosSubscription?.cancel();
    super.dispose();
  }
}

class ArticulosNotifier extends StateNotifier<ArticulosState> {
  final CombinedRepository repository;

  ArticulosNotifier({required this.repository}) : super(ArticulosState()) {
    loadArticulos();
  }

  Future<void> loadArticulos() async {
    if (state.isLoading || state.isLastPage) return;

    state = state.copyWith(isLoading: true);

    try {
      final articulos = await repository.getArticulosByPage(
          size: state.size, page: state.page);

      if (articulos.isEmpty) {
        state = state.copyWith(isLastPage: true, isLoading: false);
      } else {
        state = state.copyWith(
          isLastPage: false,
          isLoading: false,
          articulos: [...state.articulos, ...articulos],
          page: state.page + 1,
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future syncArticulos() async {
    final articulos = await repository.syncArticulos();

    state = state.copyWith(articulos: articulos);
  }

  Future<List<Articulo>> searchArticulo(String term) async {
    try {
      final articulos = await repository.searchArticulosByTerm(term);
      state = state.copyWith(articulos: articulos);
      return articulos;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return [];
    }
  }
}

class ArticulosState {
  final bool isLastPage;
  final int size;
  final int page;
  final bool isLoading;
  final List<Articulo> articulos;
  final String? error;

  ArticulosState({
    this.isLastPage = false,
    this.size = 10,
    this.page = 0,
    this.isLoading = false,
    this.articulos = const [],
    this.error,
  });

  ArticulosState copyWith({
    bool? isLastPage,
    int? size,
    int? page,
    bool? isLoading,
    List<Articulo>? articulos,
    String? error,
  }) =>
      ArticulosState(
        isLastPage: isLastPage ?? this.isLastPage,
        size: size ?? this.size,
        page: page ?? this.page,
        isLoading: isLoading ?? this.isLoading,
        articulos: articulos ?? this.articulos,
        error: error ?? this.error,
      );
}
