import 'package:ruta_demo/main/domain/entities/entities.dart';
import 'package:ruta_demo/main/presentation/providers/cobradores_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ruta_demo/main/presentation/widgets/widgets.dart';

class CobradoresScreen extends ConsumerWidget {
  const CobradoresScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Clientes'),
          actions: [
            IconButton(
                onPressed: () {
                  ref.read(cobradoresProvider.notifier).syncCobradores();
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
        body: const _CobradoresView(),
        drawer: const CustomdDrawer());
  }
}

class _CobradoresView extends ConsumerStatefulWidget {
  const _CobradoresView();

  @override
  _CobradoresViewState createState() => _CobradoresViewState();
}

class _CobradoresViewState extends ConsumerState {
  @override
  void initState() {
    super.initState();
    ref.read(cobradoresProvider.notifier).loadCobradores();
  }

  @override
  Widget build(BuildContext context) {
    final cobradoresState = ref.watch(cobradoresProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Text('Cobradores cargados: ${cobradoresState.cobradores.length}'),
          Flexible(
              child: CobradoresList(cobradores: cobradoresState.cobradores)),
        ],
      ),
    );
  }
}

class CobradoresList extends StatefulWidget {
  final List<Cobrador> cobradores;

  const CobradoresList({super.key, required this.cobradores});

  @override
  _CobradoresListState createState() => _CobradoresListState();
}

class _CobradoresListState extends State<CobradoresList> {
  String searchTerm = '';

  @override
  Widget build(BuildContext context) {
    List<Cobrador> filteredCobradores = widget.cobradores.where((cobrador) {
      return cobrador.nombre.toLowerCase().contains(searchTerm.toLowerCase()) ||
          cobrador.id
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
                labelText: ' Buscar Cobradores',
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
              itemCount: filteredCobradores.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ListTile(
                    title: Text(filteredCobradores[index].nombre),
                    trailing: Text(
                      filteredCobradores[index].id.toString(),
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    onTap: () {
                      // Handle Cobrador selection
                      print(
                          'Selected Cobrador ID: ${filteredCobradores[index].id}');
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
