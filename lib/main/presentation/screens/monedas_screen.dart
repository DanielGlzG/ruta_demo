import 'package:ruta_demo/main/domain/entities/entities.dart';
import 'package:ruta_demo/main/presentation/providers/monedas_provider.dart';
import 'package:ruta_demo/main/presentation/providers/repository_provider.dart';
import 'package:ruta_demo/main/presentation/widgets/customDrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MonedasScreen extends ConsumerWidget {
  const MonedasScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final searchArticulo = ref.watch(MonedasProvider.notifier).searchArticulo;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Monedas'),
          actions: [
            // const Conectiondisplay(),
            IconButton(
                onPressed: () {
                  ref.read(mixRepositoryProvider).syncMonedas();
                },
                icon: const Icon(Icons.sync)),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                // showSearch(
                //     context: context,
                //     delegate: SearchArticuloDelegate(
                //         initialMonedas: [], searchArticulo: searchArticulo));
              },
            ),
          ],
        ),
        body: const _MonedasView(),
        drawer: const CustomdDrawer());
  }
}

class _MonedasView extends ConsumerStatefulWidget {
  const _MonedasView();

  @override
  _MonedasViewState createState() => _MonedasViewState();
}

class _MonedasViewState extends ConsumerState {
  @override
  void initState() {
    super.initState();
    ref.read(monedasProvider.notifier).loadMonedas();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final monedasState = ref.watch(monedasProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Text('Monedas cargados: ${monedasState.monedas.length}'),
          Flexible(child: MonedasList(monedas: monedasState.monedas)),
        ],
      ),
    );
  }
}

class MonedasList extends StatefulWidget {
  final List<Moneda> monedas;

  const MonedasList({super.key, required this.monedas});

  @override
  _MonedasListState createState() => _MonedasListState();
}

class _MonedasListState extends State<MonedasList> {
  String searchTerm = '';

  @override
  Widget build(BuildContext context) {
    List<Moneda> filteredMonedas = widget.monedas.where((moneda) {
      return moneda.nombre.toLowerCase().contains(searchTerm.toLowerCase()) ||
          moneda.id.toString().toLowerCase().contains(searchTerm.toLowerCase());
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: ' Buscar monedas',
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
              itemCount: filteredMonedas.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ListTile(
                    title: Text(filteredMonedas[index].nombre),
                    trailing: Text(
                      filteredMonedas[index].id.toString(),
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    onTap: () {
                      // Handle moneda selection
                      print('Selected moneda ID: ${filteredMonedas[index].id}');
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
