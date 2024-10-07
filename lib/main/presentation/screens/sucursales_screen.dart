import 'package:ruta_demo/main/domain/entities/entities.dart';
import 'package:ruta_demo/main/presentation/providers/Sucursales_provider.dart';
import 'package:ruta_demo/main/presentation/providers/repository_provider.dart';
import 'package:ruta_demo/main/presentation/widgets/customDrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SucursalesScreen extends ConsumerWidget {
  const SucursalesScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final searchArticulo = ref.watch(SucursalesProvider.notifier).searchArticulo;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sucursales'),
          actions: [
            // const Conectiondisplay(),
            IconButton(
                onPressed: () {
                  ref.read(mixRepositoryProvider).syncSucursales();
                },
                icon: const Icon(Icons.sync)),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                // showSearch(
                //     context: context,
                //     delegate: SearchArticuloDelegate(
                //         initialSucursales: [], searchArticulo: searchArticulo));
              },
            ),
          ],
        ),
        body: const _SucursalesView(),
        drawer: const CustomdDrawer());
  }
}

class _SucursalesView extends ConsumerStatefulWidget {
  const _SucursalesView();

  @override
  _SucursalesViewState createState() => _SucursalesViewState();
}

class _SucursalesViewState extends ConsumerState {
  @override
  void initState() {
    super.initState();
    ref.read(sucursalesProvider.notifier).loadSucursales();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sucursalesState = ref.watch(sucursalesProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Text('Sucursales cargados: ${sucursalesState.sucursales.length}'),
          Flexible(
              child: SucursalesList(sucursales: sucursalesState.sucursales)),
        ],
      ),
    );
  }
}

class SucursalesList extends StatefulWidget {
  final List<Sucursal> sucursales;

  const SucursalesList({super.key, required this.sucursales});

  @override
  _SucursalesListState createState() => _SucursalesListState();
}

class _SucursalesListState extends State<SucursalesList> {
  String searchTerm = '';

  @override
  Widget build(BuildContext context) {
    List<Sucursal> filteredSucursales = widget.sucursales.where((sucursal) {
      return sucursal.nombre.toLowerCase().contains(searchTerm.toLowerCase()) ||
          sucursal.id
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
                labelText: ' Buscar sucursales',
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
              itemCount: filteredSucursales.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ListTile(
                    title: Text(filteredSucursales[index].nombre),
                    trailing: Text(
                      filteredSucursales[index].id.toString(),
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    onTap: () {
                      print(
                          'Selected sucursales ID: ${filteredSucursales[index].id}');
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
