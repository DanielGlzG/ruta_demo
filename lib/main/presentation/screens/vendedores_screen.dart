import 'package:ruta_demo/main/domain/entities/entities.dart';
import 'package:ruta_demo/main/presentation/providers/repository_provider.dart';
import 'package:ruta_demo/main/presentation/providers/vendedores_provider.dart';
import 'package:ruta_demo/main/presentation/widgets/customDrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VendedoresScreen extends ConsumerWidget {
  const VendedoresScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final searchArticulo = ref.watch(VendedoresProvider.notifier).searchArticulo;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Vendedores'),
          actions: [
            // const Conectiondisplay(),
            IconButton(
                onPressed: () {
                  ref.read(mixRepositoryProvider).syncVendedores();
                },
                icon: const Icon(Icons.sync)),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                // showSearch(
                //     context: context,
                //     delegate: SearchArticuloDelegate(
                //         initialVendedores: [], searchArticulo: searchArticulo));
              },
            ),
          ],
        ),
        body: const _VendedoresView(),
        drawer: const CustomdDrawer());
  }
}

class _VendedoresView extends ConsumerStatefulWidget {
  const _VendedoresView();

  @override
  _VendedoresViewState createState() => _VendedoresViewState();
}

class _VendedoresViewState extends ConsumerState {
  @override
  void initState() {
    super.initState();
    ref.read(vendedoresProvider.notifier).loadVendedores();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vendedoresState = ref.watch(vendedoresProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Text('Vendedores cargados: ${vendedoresState.vendedores.length}'),
          Flexible(
              child: VendedoresList(vendedores: vendedoresState.vendedores)),
        ],
      ),
    );
  }
}

class VendedoresList extends StatefulWidget {
  final List<Vendedor> vendedores;

  const VendedoresList({super.key, required this.vendedores});

  @override
  _VendedoresListState createState() => _VendedoresListState();
}

class _VendedoresListState extends State<VendedoresList> {
  String searchTerm = '';

  @override
  Widget build(BuildContext context) {
    List<Vendedor> filteredVendedores = widget.vendedores.where((vendedor) {
      return vendedor.nombre.toLowerCase().contains(searchTerm.toLowerCase()) ||
          vendedor.id
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
                labelText: ' Buscar vendedores',
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
              itemCount: filteredVendedores.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ListTile(
                    title: Text(filteredVendedores[index].nombre),
                    trailing: Text(
                      filteredVendedores[index].id.toString(),
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    onTap: () {
                      // Handle client selection
                      print(
                          'Selected vendedor ID: ${filteredVendedores[index].id}');
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
