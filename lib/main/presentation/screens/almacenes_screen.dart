import 'package:ruta_demo/main/domain/entities/entities.dart';
import 'package:ruta_demo/main/presentation/providers/almacenes_provider.dart';
import 'package:ruta_demo/main/presentation/providers/repository_provider.dart';
import 'package:ruta_demo/main/presentation/widgets/customDrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AlmacenesScreen extends ConsumerWidget {
  const AlmacenesScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Almacenes'),
          actions: [
            IconButton(
                onPressed: () {
                  ref.read(mixRepositoryProvider).syncAlmacenes();
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
        body: const _AlmacenesView(),
        drawer: const CustomdDrawer());
  }
}

class _AlmacenesView extends ConsumerStatefulWidget {
  const _AlmacenesView();

  @override
  _AlmacenesViewState createState() => _AlmacenesViewState();
}

class _AlmacenesViewState extends ConsumerState {
  @override
  void initState() {
    super.initState();
    ref.read(almacenesProvider.notifier).loadAlmacenes();
  }

  @override
  Widget build(BuildContext context) {
    final almacenesState = ref.watch(almacenesProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Text('Almacenes cargados: ${almacenesState.almacenes.length}'),
          Flexible(child: AlmacenesList(almacenes: almacenesState.almacenes)),
        ],
      ),
    );
  }
}

class AlmacenesList extends StatefulWidget {
  final List<Almacen> almacenes;

  const AlmacenesList({super.key, required this.almacenes});

  @override
  _AlmacenesListState createState() => _AlmacenesListState();
}

class _AlmacenesListState extends State<AlmacenesList> {
  String searchTerm = '';

  @override
  Widget build(BuildContext context) {
    List<Almacen> filteredAlmacenes = widget.almacenes.where((almacen) {
      return almacen.nombre.toLowerCase().contains(searchTerm.toLowerCase()) ||
          almacen.id
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
                labelText: ' Buscar Almacenes',
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
              itemCount: filteredAlmacenes.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ListTile(
                    title: Text(filteredAlmacenes[index].nombre),
                    trailing: Text(
                      filteredAlmacenes[index].id.toString(),
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    onTap: () {
                      print(
                          'Selected almacen ID: ${filteredAlmacenes[index].id}');
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
