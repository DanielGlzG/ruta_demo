import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class SqliteDatasource {
  static SqliteDatasource? _databaseHelper;
  SqliteDatasource._internal();
  static SqliteDatasource get instance =>
      _databaseHelper ??= SqliteDatasource._internal();
  late Database? database;
  Database get db => database!;

  static Future<void> iniciarDb() async {
    WidgetsFlutterBinding.ensureInitialized();
    await SqliteDatasource.instance.init();
  }

  Future<void> init() async {
    database = await openDatabase('database.db',
        version: 7, // Aumentamos la versión para activar onUpgrade
        onCreate: (db, version) {
      db.execute(
          'CREATE TABLE IF NOT EXISTS articulos (articuloId INTEGER PRIMARY KEY, nombre TEXT, estatus TEXT)');
      db.execute(
          'CREATE TABLE IF NOT EXISTS sucursales (sucursalId INTEGER PRIMARY KEY, nombre TEXT, nombreAbrev TEXT)');
      db.execute(
          'CREATE TABLE IF NOT EXISTS cobradores (cobradorId INTEGER PRIMARY KEY, nombre TEXT)');
      db.execute(
          'CREATE TABLE IF NOT EXISTS vendedores (vendedorId INTEGER PRIMARY KEY, nombre TEXT)');
      db.execute(
          'CREATE TABLE IF NOT EXISTS almacenes (almacenId INTEGER PRIMARY KEY, nombre TEXT, nombreAbrev TEXT)');
      db.execute(
          'CREATE TABLE IF NOT EXISTS monedas (monedaId INTEGER PRIMARY KEY, nombre TEXT, simbolo TEXT, claveFiscal TEXT)');

      db.execute('''
    CREATE TABLE IF NOT EXISTS pedidos (
      doctoVeId INTEGER PRIMARY KEY, 
      tipoDocto TEXT, 
      subTipoDocto TEXT, 
      sucursalId INTEGER, 
      folio TEXT, 
      fecha TEXT, 
      hora TEXT, 
      claveCliente TEXT, 
      clienteId INTEGER, 
      dirCliId INTEGER, 
      dirConsigId INTEGER, 
      almacenId INTEGER, 
      lugarExpedicionId INTEGER, 
      monedaId INTEGER, 
      tipoCambio REAL, 
      tipoDscto TEXT, 
      dsctoPctje REAL, 
      dsctoImporte REAL, 
      estatus TEXT, 
      aplicado TEXT, 
      fechaVigenciaEntrega TEXT, 
      ordenCompra TEXT, 
      fechaOrdenCompra TEXT, 
      folioReciboMercancia TEXT, 
      fechaReciboMercancia TEXT, 
      descripcion TEXT, 
      importeNeto REAL, 
      fletes REAL, 
      otrosCargos REAL, 
      totalImpuestos REAL, 
      totalRetenciones REAL, 
      totalAnticipos REAL, 
      pesoEmbarque REAL, 
      formaEmitida TEXT, 
      contabilizado TEXT, 
      acreditarCxc TEXT, 
      sistemaOrigen TEXT, 
      condPagoId INTEGER, 
      fechaDsctoPpag TEXT, 
      pctjeDsctoPpag REAL, 
      vendedorId INTEGER, 
      pctjeComis REAL, 
      viaEmbarqueId INTEGER, 
      importeCobro REAL, 
      descripcionCobro TEXT, 
      impuestoSustituidoId INTEGER, 
      impuestoSustitutoId INTEGER, 
      usuarioCreador TEXT, 
      esCfd TEXT, 
      modalidadFacturacion TEXT, 
      enviado TEXT, 
      fechaHoraEnvio TEXT, 
      emailEnvio TEXT, 
      cfdEnvioEspecial TEXT, 
      usoCfdi TEXT, 
      cfdiCertificado TEXT, 
      metodoPagoSat TEXT, 
      cfdiFactDevueltaId INTEGER, 
      fechaHoraCreacion TEXT, 
      usuarioUltModif TEXT, 
      usuarioAutCreacion TEXT, 
      fechaHoraUltModif TEXT, 
      cargarSun TEXT, 
      usuarioAutModif TEXT, 
      usuarioCancelacion TEXT, 
      fechaHoraCancelacion TEXT, 
      usuarioAutCancelacion TEXT,
      detalles TEXT
    );
  ''');

      db.execute(
          'CREATE TABLE IF NOT EXISTS clientes (clienteId INTEGER PRIMARY KEY, nombre TEXT, cobradorId INTEGER, vendedorId INTEGER, monedaId INTEGER)');
      db.execute(
          'CREATE TABLE IF NOT EXISTS condicionesPago (condPagoId INTEGER PRIMARY KEY, nombre TEXT)');
    }, onUpgrade: (db, oldVersion, newVersion) async {
      // En onUpgrade puedes realizar cambios como eliminar tablas
      if (oldVersion == 6 && newVersion == 7) {
        deleteTable(db, 'pedidos');
        db.execute('''
    CREATE TABLE IF NOT EXISTS pedidos (
      doctoVeId INTEGER PRIMARY KEY, 
      tipoDocto TEXT, 
      subTipoDocto TEXT, 
      sucursalId INTEGER, 
      folio TEXT, 
      fecha TEXT, 
      hora TEXT, 
      claveCliente TEXT, 
      clienteId INTEGER, 
      dirCliId INTEGER, 
      dirConsigId INTEGER, 
      almacenId INTEGER, 
      lugarExpedicionId INTEGER, 
      monedaId INTEGER, 
      tipoCambio REAL, 
      tipoDscto TEXT, 
      dsctoPctje REAL, 
      dsctoImporte REAL, 
      estatus TEXT, 
      aplicado TEXT, 
      fechaVigenciaEntrega TEXT, 
      ordenCompra TEXT, 
      fechaOrdenCompra TEXT, 
      folioReciboMercancia TEXT, 
      fechaReciboMercancia TEXT, 
      descripcion TEXT, 
      importeNeto REAL, 
      fletes REAL, 
      otrosCargos REAL, 
      totalImpuestos REAL, 
      totalRetenciones REAL, 
      totalAnticipos REAL, 
      pesoEmbarque REAL, 
      formaEmitida TEXT, 
      contabilizado TEXT, 
      acreditarCxc TEXT, 
      sistemaOrigen TEXT, 
      condPagoId INTEGER, 
      fechaDsctoPpag TEXT, 
      pctjeDsctoPpag REAL, 
      vendedorId INTEGER, 
      pctjeComis REAL, 
      viaEmbarqueId INTEGER, 
      importeCobro REAL, 
      descripcionCobro TEXT, 
      impuestoSustituidoId INTEGER, 
      impuestoSustitutoId INTEGER, 
      usuarioCreador TEXT, 
      esCfd TEXT, 
      modalidadFacturacion TEXT, 
      enviado TEXT, 
      fechaHoraEnvio TEXT, 
      emailEnvio TEXT, 
      cfdEnvioEspecial TEXT, 
      usoCfdi TEXT, 
      cfdiCertificado TEXT, 
      metodoPagoSat TEXT, 
      cfdiFactDevueltaId INTEGER, 
      fechaHoraCreacion TEXT, 
      usuarioUltModif TEXT, 
      usuarioAutCreacion TEXT, 
      fechaHoraUltModif TEXT, 
      cargarSun TEXT, 
      usuarioAutModif TEXT, 
      usuarioCancelacion TEXT, 
      fechaHoraCancelacion TEXT, 
      usuarioAutCancelacion TEXT,
      detalles TEXT
    );
  ''');
      }
    });
  }

  Future<void> deleteTable(Database db, String tableName) async {
    await db.execute('DROP TABLE IF EXISTS $tableName');
  }
}
