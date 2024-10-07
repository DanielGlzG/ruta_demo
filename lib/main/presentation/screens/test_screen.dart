import 'package:ruta_demo/main/presentation/providers/Clientes_provider.dart';
import 'package:ruta_demo/main/presentation/providers/repository_provider.dart';
import 'package:ruta_demo/main/presentation/widgets/customDrawer.dart';
import 'package:ruta_demo/main/presentation/widgets/test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TestScreen extends ConsumerWidget {
  const TestScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Clientes'),
          actions: [
            IconButton(
                onPressed: () {
                  ref.read(mixRepositoryProvider).syncClientes();
                },
                icon: const Icon(Icons.sync)),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
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
  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(clientesProvider.notifier).loadClientes();
    });

    scrollController.addListener(() {
      if ((scrollController.position.pixels) >=
          scrollController.position.maxScrollExtent) {
        ref.read(clientesProvider.notifier).loadClientes();
      }
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
          Flexible(
            child: ClientList(
              clientes: clientesState.clientes,
            ),
          )
        ],
      ),
    );
  }
}
