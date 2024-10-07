import 'package:ruta_demo/main/domain/entities/pedido.dart';
import 'package:ruta_demo/main/presentation/widgets/partidasWidget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pedidoFormProvider = StateNotifierProvider.autoDispose
    .family<PedidosFormNotifier, PedidosFormState, Pedido>((ref, pedido) {
  // final createUpdateCallback =
  //     ref.watch(pedidosProvider.notifier).guardarPedido(pedido);

  return PedidosFormNotifier(pedido: pedido);
});

class PedidosFormNotifier extends StateNotifier<PedidosFormState> {
  PedidosFormNotifier({required Pedido pedido})
      : super(PedidosFormState(
            folio: pedido.folio,
            sucursalId: pedido.sucursalId,
            clienteId: pedido.clienteId,
            almacenId: pedido.almacenId,
            monedaId: pedido.monedaId,
            condicionPagoId: pedido.condPagoId,
            partidas: pedido.partidas));

  void onFolioChanged(String value) {
    state = state.copyWith(folio: value);
  }

  void onSucursalChanged(int value) {
    state = state.copyWith(sucursalId: value);
  }

  void onAlmacenChanged(int value) {
    state = state.copyWith(almacenId: value);
  }

  void onMonedaChanged(int value) {
    state = state.copyWith(monedaId: value);
  }

  void onCondicionPagoChanged(int value) {
    state = state.copyWith(condicionPagoId: value);
  }

  void onClienteChanged(int value) {
    state = state.copyWith(clienteId: value);
  }

  void onPartidasChanged(List<PartidaPedido> partidas) {
    state = state.copyWith(partidas: partidas);
  }

  Pedido onFormSubmit() {
    return Pedido(
        doctoVeId: -1,
        tipoDocto: "P",
        subTipoDocto: "N",
        sucursalId: state.sucursalId,
        folio: state.folio,
        fecha: DateTime.parse("2024-09-20"),
        hora: "12:45:03",
        claveCliente: null,
        clienteId: state.clienteId,
        dirCliId: 11810,
        dirConsigId: 11810,
        almacenId: state.almacenId,
        lugarExpedicionId: null,
        monedaId: state.monedaId,
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
        condPagoId: state.condicionPagoId,
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
        partidas: state.partidas);
  }
}

class PedidosFormState {
  final String folio;
  final int sucursalId;
  final int clienteId;
  final int almacenId;
  final int monedaId;
  final int condicionPagoId;
  final List<PartidaPedido> partidas;

  PedidosFormState(
      {required this.folio,
      required this.sucursalId,
      required this.clienteId,
      required this.almacenId,
      required this.monedaId,
      required this.condicionPagoId,
      this.partidas = const []});

  PedidosFormState copyWith({
    String? folio,
    int? articuloId,
    int? sucursalId,
    int? clienteId,
    int? almacenId,
    int? monedaId,
    int? condicionPagoId,
    List<PartidaPedido>? partidas,
  }) =>
      PedidosFormState(
        folio: folio ?? this.folio,
        sucursalId: sucursalId ?? this.sucursalId,
        clienteId: clienteId ?? this.clienteId,
        almacenId: almacenId ?? this.almacenId,
        monedaId: monedaId ?? this.monedaId,
        condicionPagoId: condicionPagoId ?? this.condicionPagoId,
        partidas: partidas ?? this.partidas,
      );
}
