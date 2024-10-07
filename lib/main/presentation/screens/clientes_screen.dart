import 'package:ruta_demo/main/domain/entities/entities.dart';
import 'package:ruta_demo/main/presentation/providers/clientes_provider.dart';
import 'package:ruta_demo/main/presentation/widgets/customDrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClientesScreen extends ConsumerWidget {
  const ClientesScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Clientes'),
          actions: [
            IconButton(
                onPressed: () {
                  ref.read(clientesProvider.notifier).syncClientes();
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
        body: const _ClientesView(),
        drawer: const CustomdDrawer());
  }
}

class _ClientesView extends ConsumerStatefulWidget {
  const _ClientesView();

  @override
  _ClientesViewState createState() => _ClientesViewState();
}

class _ClientesViewState extends ConsumerState {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(clientesProvider.notifier).loadClientes();
    });
  }

  @override
  Widget build(BuildContext context) {
    final clientesState = ref.watch(clientesProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Text('Clientes cargados: ${clientesState.clientes.length}'),
          Flexible(child: ClientList(clientes: clientesState.clientes)),
        ],
      ),
    );
  }
}

class ClientList extends StatefulWidget {
  final List<Cliente> clientes;

  const ClientList({super.key, required this.clientes});

  @override
  _ClientListState createState() => _ClientListState();
}

class _ClientListState extends State<ClientList> {
  String searchTerm = '';

  @override
  Widget build(BuildContext context) {
    List<Cliente> filteredClients = widget.clientes.where((cliente) {
      return cliente.nombre.toLowerCase().contains(searchTerm.toLowerCase()) ||
          cliente.id
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
                labelText: ' Buscar Clientes',
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
              itemCount: filteredClients.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ListTile(
                    title: Text(filteredClients[index].nombre),
                    trailing: Text(
                      filteredClients[index].id.toString(),
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    onTap: () {
                      print('Selected client ID: ${filteredClients[index].id}');
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
