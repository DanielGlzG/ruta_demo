import '../../../config/db/fireBase.dart';
import '../../domain/datasources/microsip_datasource.dart';
import '../../domain/entities/entities.dart';
import '../mappers/mappers.dart';

class FirestoreDatasource extends MicrosipDatasource {
  final database = FireBaseFireStore().firestoreInstance;

  @override
  Future enviarPedido(Pedido pedido) {
    // TODO: implement enviarPedido
    throw UnimplementedError();
  }

  @override
  Future<Almacen> getAlmacenById(int id) {
    // TODO: implement getAlmacenById
    throw UnimplementedError();
  }

  @override
  Future<List<Almacen>> getAlmacenes() {
    // TODO: implement getAlmacenes
    throw UnimplementedError();
  }

  @override
  Future<List<Almacen>> getAlmacenesByPage({int size = 10, int page = 0}) {
    // TODO: implement getAlmacenesByPage
    throw UnimplementedError();
  }

  @override
  Future<Articulo> getArticuloById(int id) {
    // TODO: implement getArticuloById
    throw UnimplementedError();
  }

  @override
  Future<List<Articulo>> getArticulos() async {
    try {
      final data = await database.collection('articulos').get();
      print('Hay localmente ${data.size} articulos');
      return data.docs
          .map((articulo) => ArticuloMapper.jsonToEntity(articulo.data()))
          .toList();
    } catch (e) {
      print('Error obteniendo artículos: $e');
      return [];
    }
  }

  @override
  Future<List<Articulo>> getArticulosByPage({int size = 10, int page = 0}) {
    // TODO: implement getArticulosByPage
    throw UnimplementedError();
  }

  @override
  Future<Cliente> getClienteById(int id) {
    // TODO: implement getClienteById
    throw UnimplementedError();
  }

  @override
  Future<List<Cliente>> getClientes() {
    // TODO: implement getClientes
    throw UnimplementedError();
  }

  @override
  Future<List<Cliente>> getClientesByPage({int size = 10, int page = 0}) {
    // TODO: implement getClientesByPage
    throw UnimplementedError();
  }

  @override
  Future<Cobrador> getCobradorById(int id) {
    // TODO: implement getCobradorById
    throw UnimplementedError();
  }

  @override
  Future<List<Cobrador>> getCobradores() {
    // TODO: implement getCobradores
    throw UnimplementedError();
  }

  @override
  Future<List<Cobrador>> getCobradoresByPage({int size = 10, int page = 0}) {
    // TODO: implement getCobradoresByPage
    throw UnimplementedError();
  }

  @override
  Future<CondicionPago> getCondicionPagoById(int id) {
    // TODO: implement getCondicionPagoById
    throw UnimplementedError();
  }

  @override
  Future<List<CondicionPago>> getCondicionesPago() {
    // TODO: implement getCondicionesPago
    throw UnimplementedError();
  }

  @override
  Future<List<CondicionPago>> getCondicionesPagoByPage(
      {int size = 10, int page = 0}) {
    // TODO: implement getCondicionesPagoByPage
    throw UnimplementedError();
  }

  @override
  Future<Moneda> getMonedaById(int id) {
    // TODO: implement getMonedaById
    throw UnimplementedError();
  }

  @override
  Future<List<Moneda>> getMonedas() {
    // TODO: implement getMonedas
    throw UnimplementedError();
  }

  @override
  Future<List<Moneda>> getMonedasByPage({int size = 10, int page = 0}) {
    // TODO: implement getMonedasByPage
    throw UnimplementedError();
  }

  @override
  Future<Sucursal> getSucursalById(int id) {
    // TODO: implement getSucursalById
    throw UnimplementedError();
  }

  @override
  Future<List<Sucursal>> getSucursales() {
    // TODO: implement getSucursales
    throw UnimplementedError();
  }

  @override
  Future<List<Sucursal>> getSucursalesByPage({int size = 10, int page = 0}) {
    // TODO: implement getSucursalesByPage
    throw UnimplementedError();
  }

  @override
  Future<Vendedor> getVendedorById(int id) {
    // TODO: implement getVendedorById
    throw UnimplementedError();
  }

  @override
  Future<List<Vendedor>> getVendedores() {
    // TODO: implement getVendedores
    throw UnimplementedError();
  }

  @override
  Future<List<Vendedor>> getVendedoresByPage({int size = 10, int page = 0}) {
    // TODO: implement getVendedoresByPage
    throw UnimplementedError();
  }

  @override
  Future<List<Almacen>> searchAlmacenesByTerm(String term) {
    // TODO: implement searchAlmacenesByTerm
    throw UnimplementedError();
  }

  @override
  Future<List<Articulo>> searchArticulosByTerm(String term) {
    // TODO: implement searchArticulosByTerm
    throw UnimplementedError();
  }

  @override
  Future<List<Cliente>> searchClientesByTerm(String term) {
    // TODO: implement searchClientesByTerm
    throw UnimplementedError();
  }

  @override
  Future<List<Cobrador>> searchCobradoresByTerm(String term) {
    // TODO: implement searchCobradoresByTerm
    throw UnimplementedError();
  }

  @override
  Future<List<CondicionPago>> searchCondicionesPagoByTerm(String term) {
    // TODO: implement searchCondicionesPagoByTerm
    throw UnimplementedError();
  }

  @override
  Future<List<Moneda>> searchMonedasByTerm(String term) {
    // TODO: implement searchMonedasByTerm
    throw UnimplementedError();
  }

  @override
  Future<List<Sucursal>> searchSucursalesByTerm(String term) {
    // TODO: implement searchSucursalesByTerm
    throw UnimplementedError();
  }

  @override
  Future<List<Vendedor>> searchVendedoresByTerm(String term) {
    // TODO: implement searchVendedoresByTerm
    throw UnimplementedError();
  }
}
