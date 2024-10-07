import 'package:ruta_demo/main/presentation/widgets/partidasWidget.dart';

class Pedido {
  final int doctoVeId;
  final String tipoDocto;
  final String subTipoDocto;
  final int sucursalId;
  final String folio;
  final DateTime fecha;
  final String hora;
  final dynamic claveCliente;
  final int clienteId;
  final int dirCliId;
  final int dirConsigId;
  final int almacenId;
  final dynamic lugarExpedicionId;
  final int monedaId;
  final double tipoCambio;
  final String tipoDscto;
  final double dsctoPctje;
  final double dsctoImporte;
  final String estatus;
  final String aplicado;
  final DateTime fechaVigenciaEntrega;
  final dynamic ordenCompra;
  final dynamic fechaOrdenCompra;
  final dynamic folioReciboMercancia;
  final dynamic fechaReciboMercancia;
  final dynamic descripcion;
  final double importeNeto;
  final double fletes;
  final double otrosCargos;
  final double totalImpuestos;
  final double totalRetenciones;
  final double totalAnticipos;
  final double pesoEmbarque;
  final String formaEmitida;
  final String contabilizado;
  final String acreditarCxc;
  final String sistemaOrigen;
  final int condPagoId;
  final dynamic fechaDsctoPpag;
  final double pctjeDsctoPpag;
  final dynamic vendedorId;
  final double pctjeComis;
  final dynamic viaEmbarqueId;
  final double importeCobro;
  final dynamic descripcionCobro;
  final dynamic impuestoSustituidoId;
  final dynamic impuestoSustitutoId;
  final String usuarioCreador;
  final String esCfd;
  final dynamic modalidadFacturacion;
  final String enviado;
  final dynamic fechaHoraEnvio;
  final dynamic emailEnvio;
  final String cfdEnvioEspecial;
  final dynamic usoCfdi;
  final String cfdiCertificado;
  final dynamic metodoPagoSat;
  final dynamic cfdiFactDevueltaId;
  final DateTime fechaHoraCreacion;
  final String usuarioUltModif;
  final dynamic usuarioAutCreacion;
  final DateTime fechaHoraUltModif;
  final String cargarSun;
  final dynamic usuarioAutModif;
  final dynamic usuarioCancelacion;
  final dynamic fechaHoraCancelacion;
  final dynamic usuarioAutCancelacion;
  final List<PartidaPedido> partidas;

  Pedido({
    required this.doctoVeId,
    required this.tipoDocto,
    required this.subTipoDocto,
    required this.sucursalId,
    required this.folio,
    required this.fecha,
    required this.hora,
    required this.claveCliente,
    required this.clienteId,
    required this.dirCliId,
    required this.dirConsigId,
    required this.almacenId,
    required this.lugarExpedicionId,
    required this.monedaId,
    required this.tipoCambio,
    required this.tipoDscto,
    required this.dsctoPctje,
    required this.dsctoImporte,
    required this.estatus,
    required this.aplicado,
    required this.fechaVigenciaEntrega,
    required this.ordenCompra,
    required this.fechaOrdenCompra,
    required this.folioReciboMercancia,
    required this.fechaReciboMercancia,
    required this.descripcion,
    required this.importeNeto,
    required this.fletes,
    required this.otrosCargos,
    required this.totalImpuestos,
    required this.totalRetenciones,
    required this.totalAnticipos,
    required this.pesoEmbarque,
    required this.formaEmitida,
    required this.contabilizado,
    required this.acreditarCxc,
    required this.sistemaOrigen,
    required this.condPagoId,
    required this.fechaDsctoPpag,
    required this.pctjeDsctoPpag,
    required this.vendedorId,
    required this.pctjeComis,
    required this.viaEmbarqueId,
    required this.importeCobro,
    required this.descripcionCobro,
    required this.impuestoSustituidoId,
    required this.impuestoSustitutoId,
    required this.usuarioCreador,
    required this.esCfd,
    required this.modalidadFacturacion,
    required this.enviado,
    required this.fechaHoraEnvio,
    required this.emailEnvio,
    required this.cfdEnvioEspecial,
    required this.usoCfdi,
    required this.cfdiCertificado,
    required this.metodoPagoSat,
    required this.cfdiFactDevueltaId,
    required this.fechaHoraCreacion,
    required this.usuarioUltModif,
    required this.usuarioAutCreacion,
    required this.fechaHoraUltModif,
    required this.cargarSun,
    required this.usuarioAutModif,
    required this.usuarioCancelacion,
    required this.fechaHoraCancelacion,
    required this.usuarioAutCancelacion,
    this.partidas = const [],
  });
}
