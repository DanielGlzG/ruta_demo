// import 'dart:async';

// import 'package:ruta_demo/main/domain/entities/articulo.dart';
// import 'package:flutter/material.dart';

// typedef SearchArticuloCallback = Future<List<Articulo>> Function(String query);

// class SearchArticuloDelegate extends SearchDelegate<Articulo?> {
//   final SearchArticuloCallback searchArticulo;
//   final StreamController<List<Articulo>> debouncedArticulo =
//       StreamController.broadcast();

//   final StreamController<bool> isLoadingStream = StreamController.broadcast();
//   Timer? _timer;
//   List<Articulo> initialArticulos;

//   SearchArticuloDelegate(
//       {required this.searchArticulo, required this.initialArticulos});

//   void _onQueryChanged(String query) {
//     isLoadingStream.add(true);
//     if (_timer?.isActive ?? false) _timer!.cancel();

//     _timer = Timer(const Duration(milliseconds: 500), () async {
//       final articulos = await searchArticulo(query);
//       initialArticulos = articulos;
//       debouncedArticulo.add(articulos);
//       isLoadingStream.add(false);
//     });
//   }

//   void clearStreams() {
//     debouncedArticulo.close();
//   }

//   @override
//   String get searchFieldLabel => 'Buscar articulo';

//   Widget buildResultsAndSuggestions() {
//     return StreamBuilder(
//         initialData: initialArticulos,
//         stream: debouncedArticulo.stream,
//         builder: (context, snapshot) {
//           final articulos = snapshot.data ?? [];

//           return ListView.builder(
//             itemCount: articulos.length,
//             itemBuilder: (context, index) {
//               final articulo = articulos[index];
//               return ListTile(
//                 title: Text(articulo.nombre),
//               );
//             },
//           );
//         });
//   }

//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     return [
//       StreamBuilder(
//           stream: isLoadingStream.stream,
//           initialData: false,
//           builder: (context, snapshot) {
//             if (snapshot.data ?? false) {
//               return IconButton(
//                   onPressed: () => query = '',
//                   icon: const Icon(Icons.refresh_rounded));
//             }

//             return IconButton(
//                 onPressed: () => query = '', icon: const Icon(Icons.clear));
//           })
//     ];
//   }

//   @override
//   Widget? buildLeading(BuildContext context) {
//     return IconButton(
//         onPressed: () {
//           clearStreams();
//           close(context, null);
//         },
//         icon: const Icon(Icons.arrow_back));
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     return buildResultsAndSuggestions();
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     _onQueryChanged(query);
//     return buildResultsAndSuggestions();
//   }
// }


// typedef SearchCallback = Future<List<Map<String, dynamic>>> Function(
//     String query);

// class SearchDelegate extends SearchDelegate<Map<String, dynamic>?> {
//   final SearchCallback searchCallback;
//   final StreamController<List<Map<String, dynamic>>> debouncedStream =
//       StreamController.broadcast();

//   final StreamController<bool> isLoadingStream = StreamController.broadcast();
//   Timer? _timer;
//   List<Map<String, dynamic>> initialItems;

//   SearchDelegate({required this.searchCallback, required this.initialItems});

//   void _onQueryChanged(String query) {
//     isLoadingStream.add(true);
//     if (_timer?.isActive ?? false) _timer!.cancel();

//     _timer = Timer(const Duration(milliseconds: 500), () async {
//       final items = await searchCallback(query);
//       initialItems = items;
//       debouncedStream.add(items);
//       isLoadingStream.add(false);
//     });
//   }

//   void clearStreams() {
//     debouncedStream.close();
//   }

//   @override
//   String get searchFieldLabel => 'Buscar articulo';

//   Widget buildResultsAndSuggestions() {
//     return StreamBuilder(
//         initialData: initialItems,
//         stream: debouncedStream.stream,
//         builder: (context, snapshot) {
//           final items = snapshot.data ?? [];

//           return ListView.builder(
//             itemCount: items.length,
//             itemBuilder: (context, index) {
//               final item = items[index];
//               return ListTile(
//                 title: Text(item['nombre'] ?? 'no name'),
//               );
//             },
//           );
//         });
//   }

//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     return [
//       StreamBuilder(
//           stream: isLoadingStream.stream,
//           initialData: false,
//           builder: (context, snapshot) {
//             if (snapshot.data ?? false) {
//               return IconButton(
//                   onPressed: () => query = '',
//                   icon: const Icon(Icons.refresh_rounded));
//             }

//             return IconButton(
//                 onPressed: () => query = '', icon: const Icon(Icons.clear));
//           })
//     ];
//   }

//   @override
//   Widget? buildLeading(BuildContext context) {
//     return IconButton(
//         onPressed: () {
//           clearStreams();
//           close(context, null);
//         },
//         icon: const Icon(Icons.arrow_back));
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     return buildResultsAndSuggestions();
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     _onQueryChanged(query);
//     return buildResultsAndSuggestions();
//   }
// }
