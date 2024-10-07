import 'package:go_router/go_router.dart';
import 'package:ruta_demo/main/domain/entities/pedido.dart';
import 'package:ruta_demo/main/presentation/providers/Clientes_provider.dart';
import 'package:ruta_demo/main/presentation/providers/Sucursales_provider.dart';
import 'package:ruta_demo/main/presentation/providers/almacenes_provider.dart';
import 'package:ruta_demo/main/presentation/providers/articulos_provider.dart';
import 'package:ruta_demo/main/presentation/providers/condiciones_pago_provider.dart';
import 'package:ruta_demo/main/presentation/providers/monedas_provider.dart';
import 'package:ruta_demo/main/presentation/providers/pedidos_form_provider.dart';
import 'package:ruta_demo/main/presentation/providers/pedidos_provider.dart';
import 'package:ruta_demo/main/presentation/widgets/customDrawer.dart';
import 'package:ruta_demo/main/presentation/widgets/dropdownInputs/AlmacenesDropDown.dart';
import 'package:ruta_demo/main/presentation/widgets/dropdownInputs/MonedasDropDown.dart';
import 'package:ruta_demo/main/presentation/widgets/dropdownInputs/clientesDropDown.dart';
import 'package:ruta_demo/main/presentation/widgets/dropdownInputs/SucursalesDropDown.dart';
import 'package:ruta_demo/main/presentation/widgets/dropdownInputs/condicionesPagoDropDown.dart';
import 'package:ruta_demo/main/presentation/widgets/partidasWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pedido = Pedido(
  doctoVeId: -1,
  tipoDocto: "P",
  subTipoDocto: "N",
  sucursalId: 384,
  folio: "AA0000007",
  fecha: DateTime.parse("2024-09-20"),
  hora: "12:45:03",
  claveCliente: null,
  clienteId: 11809,
  dirCliId: 11810,
  dirConsigId: 11810,
  almacenId: 19,
  lugarExpedicionId: null,
  monedaId: 1,
  tipoCambio: 1.000000,
  tipoDscto: "P",
  dsctoPctje: 0.000000,
  dsctoImporte: 0.00,
  estatus: "P",
  aplicado: "S",
  fechaVigenciaEntrega: DateTime.parse("2024-09-20"),
  ordenCompra: null,
  fechaOrdenCompra: null,
  folioReciboMercancia: null,
  fechaReciboMercancia: null,
  descripcion: null,
  importeNeto: 385.00,
  fletes: 0.00,
  otrosCargos: 0.00,
  totalImpuestos: 0.00,
  totalRetenciones: 0.00,
  totalAnticipos: 0.00,
  pesoEmbarque: 0.000,
  formaEmitida: "N",
  contabilizado: "N",
  acreditarCxc: "N",
  sistemaOrigen: "VE",
  condPagoId: 10643,
  fechaDsctoPpag: null,
  pctjeDsctoPpag: 0.000000,
  vendedorId: null,
  pctjeComis: 0.000000,
  viaEmbarqueId: null,
  importeCobro: 0.00,
  descripcionCobro: null,
  impuestoSustituidoId: null,
  impuestoSustitutoId: null,
  usuarioCreador: "SYSDBA",
  esCfd: "N",
  modalidadFacturacion: null,
  enviado: "N",
  fechaHoraEnvio: null,
  emailEnvio: null,
  cfdEnvioEspecial: "N",
  usoCfdi: null,
  cfdiCertificado: "N",
  metodoPagoSat: null,
  cfdiFactDevueltaId: null,
  fechaHoraCreacion: DateTime.parse("2024-09-20T19:45:03.200+00:00"),
  usuarioUltModif: "SYSDBA",
  usuarioAutCreacion: null,
  fechaHoraUltModif: DateTime.parse("2024-09-20T19:45:03.200+00:00"),
  cargarSun: "S",
  usuarioAutModif: "SYSDBA",
  usuarioCancelacion: null,
  fechaHoraCancelacion: null,
  usuarioAutCancelacion: null,
);

class PedidosScreen extends ConsumerWidget {
  const PedidosScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pedidosState = ref.watch(pedidosProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos'),
        actions: [
          // const Conectiondisplay(),
          IconButton(
              onPressed: () {
                ref
                    .read(pedidosProvider.notifier)
                    .enviarPedidos(pedidosState.pedidos);
              },
              icon: const Icon(Icons.upload)),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // showSearch(
              //     context: context,
              //     delegate: SearchArticuloDelegate(
              //         initialPedidos: [], searchArticulo: searchArticulo));
            },
          ),
        ],
      ),
      body: const _PedidosView(),
      drawer: const CustomdDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showForm(context, ref);
        },
        child: const Icon(Icons.add),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const [
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.people_alt_outlined), label: "Pedidos"),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.details), label: "Nuevo pedido"),
      //   ],
      //   onTap: (value) => context.push("Pedidos"),
      // ),
    );
  }

  void _showForm(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
              height: 900,
              child: _FormPedido(
                pedido: pedido,
              ));
        });
  }
}

class _PedidosView extends ConsumerStatefulWidget {
  const _PedidosView();

  @override
  _PedidosViewState createState() => _PedidosViewState();
}

class _PedidosViewState extends ConsumerState {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(pedidosProvider.notifier).loadPedidos();
    });
    // scrollController.addListener(() {
    //   if ((scrollController.position.pixels) >=
    //       scrollController.position.maxScrollExtent) {
    //     ref.read(pedidosProvider.notifier).loadPedidos();
    //   }
    // });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pedidosState = ref.watch(pedidosProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Text('Pedidos cargados: ${pedidosState.pedidos.length}'),
          Flexible(child: PedidosList(pedidos: pedidosState.pedidos)),
        ],
      ),
    );
  }
}

class _FormPedido extends ConsumerWidget {
  final Pedido pedido;
  const _FormPedido({required this.pedido});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articulosState = ref.watch(articulosProvider);
    final sucursalesState = ref.watch(sucursalesProvider);
    final monedasState = ref.watch(monedasProvider);
    final condPagosState = ref.watch(condicionesPagoProvider);
    final clientesState = ref.watch(clientesProvider);
    final almacenesState = ref.watch(almacenesProvider);

    final formProvider = ref.watch(pedidoFormProvider(pedido).notifier);
    return Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
            child: Column(
          children: [
            CustomTextFormField(
              label: "folio",
              onChanged: formProvider.onFolioChanged,
            ),
            const SizedBox(
              height: 10,
            ),
            SucursalesDropdown(
              label: 'Sucursal',
              sucursales: sucursalesState.sucursales,
              initialValue: null,
              onChangeField: formProvider.onSucursalChanged,
            ),
            const SizedBox(
              height: 10,
            ),
            ClientesDropdown(
              label: "Cliente",
              clientes: clientesState.clientes,
              initialValue: null,
              onChangeField: formProvider.onClienteChanged,
            ),
            const SizedBox(
              height: 10,
            ),
            AlmacenesDropdown(
              label: "Almacen",
              almacenes: almacenesState.almacenes,
              initialValue: null,
              onChangeField: formProvider.onAlmacenChanged,
            ),
            const SizedBox(
              height: 10,
            ),
            MonedasDropdown(
              label: "Moneda",
              monedas: monedasState.monedas,
              initialValue: null,
              onChangeField: formProvider.onMonedaChanged,
            ),
            const SizedBox(
              height: 10,
            ),
            CondicionesPagoDropdown(
              label: "Condicion de pago",
              condicionesPago: condPagosState.condicionesPago,
              initialValue: null,
              onChangeField: formProvider.onCondicionPagoChanged,
            ),
            const SizedBox(
              height: 10,
            ),
            ItemsForm(
              articulos: articulosState.articulos,
              onChangeField: formProvider.onPartidasChanged,
            ),
            const SizedBox(
              height: 30,
            ),
            FilledButton(
                onPressed: () {
                  final pedidoNuevo = ref
                      .read(pedidoFormProvider(pedido).notifier)
                      .onFormSubmit();
                  ref
                      .watch(pedidosProvider.notifier)
                      .guardarPedido(pedidoNuevo);

                  Navigator.pop(context);
                },
                child: const Text("Crear"))
          ],
        )));
  }
}

class CustomTextFormField extends StatelessWidget {
  final String? label;
  final String? hint;
  final String? errorMessage;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final Function(String)? onFormSubmited;
  final String? Function(String?)? validator;

  const CustomTextFormField({
    super.key,
    this.label,
    this.hint,
    this.errorMessage,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.validator,
    this.onFormSubmited,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final border = OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(40));

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 10,
                offset: const Offset(0, 5))
          ]),
      child: TextFormField(
        onChanged: onChanged,
        validator: validator,
        onFieldSubmitted: onFormSubmited,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: const TextStyle(fontSize: 20, color: Colors.black54),
        decoration: InputDecoration(
          floatingLabelStyle: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
          enabledBorder: border,
          focusedBorder: border,
          errorBorder: border.copyWith(
              borderSide: const BorderSide(color: Colors.transparent)),
          focusedErrorBorder: border.copyWith(
              borderSide: const BorderSide(color: Colors.transparent)),
          isDense: true,
          label: label != null ? Text(label!) : null,
          hintText: hint,
          errorText: errorMessage,
          focusColor: colors.primary,
        ),
      ),
    );
  }
}

class PedidosList extends StatefulWidget {
  final List<Pedido> pedidos;

  const PedidosList({super.key, required this.pedidos});

  @override
  _PedidosListState createState() => _PedidosListState();
}

class _PedidosListState extends State<PedidosList> {
  String searchTerm = '';

  @override
  Widget build(BuildContext context) {
    List<Pedido> filteredPedidos = widget.pedidos.where((pedido) {
      return pedido.folio.toLowerCase().contains(searchTerm.toLowerCase());
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: ' Buscar pedidos',
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
              itemCount: filteredPedidos.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ListTile(
                    title: Text(filteredPedidos[index].folio),
                    trailing: Chip(
                      label: Text(
                        filteredPedidos[index].estatus.toUpperCase(),
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: filteredPedidos[index].estatus == 'C'
                          ? Colors.green
                          : filteredPedidos[index].estatus == 'P'
                              ? Colors.orange
                              : Colors.red,
                    ),
                    onTap: () {
                      // Handle client selection
                      print(
                          'Selected pedido ID: ${filteredPedidos[index].folio}');
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
