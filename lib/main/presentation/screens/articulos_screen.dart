import 'package:ruta_demo/main/domain/entities/entities.dart';
import 'package:ruta_demo/main/presentation/providers/articulos_provider.dart';
import 'package:ruta_demo/main/presentation/providers/repository_provider.dart';
import 'package:ruta_demo/main/presentation/widgets/customDrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ArticulosScreen extends ConsumerWidget {
  const ArticulosScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final searchArticulo = ref.watch(articulosProvider.notifier).searchArticulo;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Articulos'),
        actions: [
          // const Conectiondisplay(),
          IconButton(
              onPressed: () {
                ref.read(articulosProvider.notifier).syncArticulos();
              },
              icon: const Icon(Icons.sync)),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // showSearch(
              //     context: context,
              //     delegate: SearchArticuloDelegate(
              //         initialArticulos: [], searchArticulo: searchArticulo));
            },
          ),
        ],
      ),
      body: const _ArticulosView(),
      drawer: const CustomdDrawer(),
      // bottomNavigationBar: BottomNavigationBar(items: const [
      //   BottomNavigationBarItem(
      //       icon: Icon(Icons.people_alt_outlined), label: "Clientes"),
      //   BottomNavigationBarItem(icon: Icon(Icons.details), label: "Articulos"),
      //   BottomNavigationBarItem(icon: Icon(Icons.inventory), label: "Pedidos")
      // ]),
    );
  }
}

class _ArticulosView extends ConsumerStatefulWidget {
  const _ArticulosView();

  @override
  _ArticulosViewState createState() => _ArticulosViewState();
}

class _ArticulosViewState extends ConsumerState<_ArticulosView> {
  final scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(articulosProvider.notifier).loadArticulos();
      // ref.read(articulosFireBaseProvider.notifier).loadArticulos();
    });

    scrollController.addListener(() {
      if ((scrollController.position.pixels) >=
          scrollController.position.maxScrollExtent) {
        ref.read(articulosProvider.notifier).loadArticulos();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final articulosState = ref.watch(articulosFireBaseProvider);
    final articulosState = ref.watch(articulosProvider);

    return articulosState.isLoading
        ? const CircularProgressIndicator()
        : articulosState.error != null
            ? Text('Error: ${articulosState.error}')
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Text(
                        'Articulos cargados: ${articulosState.articulos.length}'),
                    Flexible(
                        child: ArticulosList(
                      articulos: articulosState.articulos,
                      scrollController: scrollController,
                    )),
                  ],
                ),
              );
  }
}

class ArticulosList extends StatefulWidget {
  final List<Articulo> articulos;
  final ScrollController scrollController;
  const ArticulosList(
      {super.key, required this.articulos, required this.scrollController});

  @override
  _ArticulosListState createState() => _ArticulosListState();
}

class _ArticulosListState extends State<ArticulosList> {
  String searchTerm = '';

  @override
  Widget build(BuildContext context) {
    List<Articulo> filteredArticulos = widget.articulos.where((articulo) {
      return articulo.nombre.toLowerCase().contains(searchTerm.toLowerCase()) ||
          articulo.id
              .toString()
              .toLowerCase()
              .contains(searchTerm.toLowerCase());
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: ' Buscar Articulos',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors
                            .black) // Borde negro cuando el campo está inactivo
                    ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.black,
                        width:
                            2.0) // Borde negro más grueso cuando el campo está activo
                    ),
              ),
              onChanged: (value) {
                setState(() {
                  searchTerm = value;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: widget.scrollController,
              itemCount: filteredArticulos.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ListTile(
                    title: Text(filteredArticulos[index].nombre),
                    trailing: Text(
                      filteredArticulos[index].id.toString(),
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    onTap: () {
                      print(
                          'Selected articulo ID: ${filteredArticulos[index].id}');
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
