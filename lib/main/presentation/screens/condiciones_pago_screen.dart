import 'package:ruta_demo/main/domain/entities/entities.dart';
import 'package:ruta_demo/main/presentation/providers/condiciones_pago_provider.dart';
import 'package:ruta_demo/main/presentation/providers/repository_provider.dart';
import 'package:ruta_demo/main/presentation/widgets/customDrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CondicionesPagoScreen extends ConsumerWidget {
  const CondicionesPagoScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('CondicionesPago'),
          actions: [
            IconButton(
                onPressed: () {
                  ref
                      .read(condicionesPagoProvider.notifier)
                      .syncCondicionesPago();
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
        body: const _CondicionesPagoView(),
        drawer: const CustomdDrawer());
  }
}

class _CondicionesPagoView extends ConsumerStatefulWidget {
  const _CondicionesPagoView();

  @override
  _CondicionesPagoViewState createState() => _CondicionesPagoViewState();
}

class _CondicionesPagoViewState extends ConsumerState {
  @override
  void initState() {
    super.initState();
    ref.read(condicionesPagoProvider.notifier).loadCondicionesPago();
  }

  @override
  Widget build(BuildContext context) {
    final condicionesPagoState = ref.watch(condicionesPagoProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Text(
              'CondicionesPago cargados: ${condicionesPagoState.condicionesPago.length}'),
          Flexible(
              child: CondicionesPagoList(
                  condicionesPago: condicionesPagoState.condicionesPago)),
        ],
      ),
    );
  }
}

class CondicionesPagoList extends StatefulWidget {
  final List<CondicionPago> condicionesPago;

  const CondicionesPagoList({super.key, required this.condicionesPago});

  @override
  _CondicionesPagoListState createState() => _CondicionesPagoListState();
}

class _CondicionesPagoListState extends State<CondicionesPagoList> {
  String searchTerm = '';

  @override
  Widget build(BuildContext context) {
    List<CondicionPago> filteredCondiPago =
        widget.condicionesPago.where((condicionPago) {
      return condicionPago.nombre
              .toLowerCase()
              .contains(searchTerm.toLowerCase()) ||
          condicionPago.id
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
                labelText: ' Buscar condiciones pago',
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
              itemCount: filteredCondiPago.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ListTile(
                    title: Text(filteredCondiPago[index].nombre),
                    trailing: Text(
                      filteredCondiPago[index].id.toString(),
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    onTap: () {
                      // Handle client selection
                      print(
                          'Selected condicion ID: ${filteredCondiPago[index].id}');
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
