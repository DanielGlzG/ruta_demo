import 'package:ruta_demo/main/domain/datasources/microsip_datasource.dart';
import 'package:ruta_demo/main/domain/entities/entities.dart';
import 'package:ruta_demo/main/domain/repositories/microsip_repository.dart';

class ApiMicrosipRepositoryImpl extends MicrosipRepository {
  final MicrosipDatasource datasource;

  ApiMicrosipRepositoryImpl(this.datasource);

  @override
  Future<Almacen> getAlmacenById(int id) {
    return datasource.getAlmacenById(id);
  }

  @override
  Future<List<Almacen>> getAlmacenByPage({int size = 10, int page = 0}) {
    return datasource.getAlmacenesByPage(page: page, size: size);
  }

  @override
  Future<List<Almacen>> getAlmacenes() {
    return datasource.getAlmacenes();
  }

  @override
  Future<Articulo> getArticuloById(int id) {
    return datasource.getArticuloById(id);
  }

  @override
  Future<List<Articulo>> getArticulos() {
    return datasource.getArticulos();
  }

  @override
  Future<List<Articulo>> getArticulosByPage({int size = 10, int page = 0}) {
    return datasource.getArticulosByPage(page: page, size: size);
  }

  @override
  Future<Cliente> getClienteById(int id) {
    return datasource.getClienteById(id);
  }

  @override
  Future<List<Cliente>> getClientes() {
    return datasource.getClientes();
  }

  @override
  Future<List<Cliente>> getClientesByPage({int size = 10, int page = 0}) {
    return datasource.getClientesByPage(page: page, size: size);
  }

  @override
  Future<Cobrador> getCobradorById(int id) {
    return datasource.getCobradorById(id);
  }

  @override
  Future<List<Cobrador>> getCobradores() {
    return datasource.getCobradores();
  }

  @override
  Future<List<Cobrador>> getCobradoresByPage({int size = 10, int page = 0}) {
    return datasource.getCobradoresByPage(page: page, size: size);
  }

  @override
  Future<Moneda> getMonedaById(int id) {
    return datasource.getMonedaById(id);
  }

  @override
  Future<List<Moneda>> getMonedas() {
    return datasource.getMonedas();
  }

  @override
  Future<List<Moneda>> getMonedasByPage({int size = 10, int page = 0}) {
    return datasource.getMonedasByPage(page: page, size: size);
  }

  @override
  Future<Sucursal> getSucursalById(int id) {
    return datasource.getSucursalById(id);
  }

  @override
  Future<List<Sucursal>> getSucursales() {
    return datasource.getSucursales();
  }

  @override
  Future<List<Sucursal>> getSucursalesByPage({int size = 10, int page = 0}) {
    return datasource.getSucursalesByPage(page: page, size: size);
  }

  @override
  Future<Vendedor> getVendedorById(int id) {
    return datasource.getVendedorById(id);
  }

  @override
  Future<List<Vendedor>> getVendedores() {
    return datasource.getVendedores();
  }

  @override
  Future<List<Vendedor>> getVendedoresByPage({int size = 10, int page = 0}) {
    return datasource.getVendedoresByPage(page: page, size: size);
  }

  @override
  Future<List<Almacen>> searchAlmacenesByTerm(String term) {
    return datasource.searchAlmacenesByTerm(term);
  }

  @override
  Future<List<Articulo>> searchArticulosByTerm(String term) {
    return datasource.searchArticulosByTerm(term);
  }

  @override
  Future<List<Cliente>> searchClientesByTerm(String term) {
    return datasource.searchClientesByTerm(term);
  }

  @override
  Future<List<Cobrador>> searchCobradoresByTerm(String term) {
    return datasource.searchCobradoresByTerm(term);
  }

  @override
  Future<List<Moneda>> searchMonedasByTerm(String term) {
    return datasource.searchMonedasByTerm(term);
  }

  @override
  Future<List<Sucursal>> searchSucursalesByTerm(String term) {
    return datasource.searchSucursalesByTerm(term);
  }

  @override
  Future<List<Vendedor>> searchVendedoresByTerm(String term) {
    return datasource.searchVendedoresByTerm(term);
  }

  @override
  Future<CondicionPago> getCondicionPagoById(int id) {
    return datasource.getCondicionPagoById(id);
  }

  @override
  Future<List<CondicionPago>> getCondicionesPago() {
    return datasource.getCondicionesPago();
  }

  @override
  Future<List<CondicionPago>> getCondicionesPagoByPage(
      {int size = 10, int page = 0}) {
    return datasource.getCondicionesPagoByPage(size: size, page: page);
  }

  @override
  Future<List<CondicionPago>> searchCondicionesPagoByTerm(String term) {
    return datasource.searchCondicionesPagoByTerm(term);
  }

  @override
  Future enviarPedido(Pedido pedido) {
    return datasource.enviarPedido(pedido);
  }
}
