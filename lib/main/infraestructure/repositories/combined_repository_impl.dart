import 'package:ruta_demo/main/domain/repositories/combined_repository.dart';
import 'package:ruta_demo/main/infraestructure/datasources/api_microsip_datasource_impl.dart';
import 'package:ruta_demo/main/infraestructure/datasources/local_datasource.dart';

import '../../domain/entities/entities.dart';

class CombinedRepositoryImpl extends CombinedRepository {
  final ApiMicrosipDatasourceImpl apiDatasource;
  final LocalDatasource localDatasource;

  CombinedRepositoryImpl({
    required this.apiDatasource,
    required this.localDatasource,
  });

  @override
  Future<void> synchAll() async {
    await syncArticulos();
    // await syncAlmacenes();
    // await syncClientes();
    // await syncCobradores();
    // await syncMonedas();
    // await syncSucursales();
    // await syncVendedores();
  }

  Future<void> savePedido(Pedido pedido) async {
    try {
      await localDatasource.savePedido(pedido);
    } catch (e) {
      print(e);
    }
  }

  Future enviarPedido(Pedido pedido) async {
    try {
      await apiDatasource.enviarPedido(pedido);
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<List<Articulo>> syncArticulos() async {
    final localData = await localDatasource.getArticulos();

    try {
      final apiData = await apiDatasource.getArticulos();

      for (final elemento in apiData) {
        await localDatasource.saveArticulo(elemento);
      }

      return apiData;
    } catch (e) {
      return localData;
    }
  }

  @override
  Future<List<Almacen>> syncAlmacenes() async {
    final localData = await localDatasource.getAlmacenes();

    try {
      final apiData = await apiDatasource.getAlmacenes();

      for (final elemento in apiData) {
        await localDatasource.saveAlmacen(elemento);
      }

      return apiData;
    } catch (e) {
      return localData;
    }
  }

  @override
  Future<List<Cliente>> syncClientes() async {
    final localData = await localDatasource.getClientes();

    try {
      final apiData = await apiDatasource.getClientes();

      for (final elemento in apiData) {
        await localDatasource.saveCliente(elemento);
      }

      return apiData;
    } catch (e) {
      return localData;
    }
  }

  @override
  Future<List<Cobrador>> syncCobradores() async {
    final localData = await localDatasource.getCobradores();

    try {
      final apiData = await apiDatasource.getCobradores();

      for (final elemento in apiData) {
        await localDatasource.saveCobrador(elemento);
      }

      return apiData;
    } catch (e) {
      return localData;
    }
  }

  @override
  Future<List<Moneda>> syncMonedas() async {
    final localData = await localDatasource.getMonedas();

    try {
      final apiData = await apiDatasource.getMonedas();

      for (final elemento in apiData) {
        await localDatasource.saveMoneda(elemento);
      }

      return apiData;
    } catch (e) {
      return localData;
    }
  }

  @override
  Future<List<CondicionPago>> syncCondicionesPago() async {
    final localData = await localDatasource.getCondicionesPago();

    try {
      final apiData = await apiDatasource.getCondicionesPago();

      for (final elemento in apiData) {
        await localDatasource.saveCondicionPago(elemento);
      }

      return apiData;
    } catch (e) {
      return localData;
    }
  }

  @override
  Future<List<Sucursal>> syncSucursales() async {
    final localData = await localDatasource.getSucursales();

    try {
      final apiData = await apiDatasource.getSucursales();

      for (final elemento in apiData) {
        await localDatasource.saveSucursal(elemento);
      }

      return apiData;
    } catch (e) {
      return localData;
    }
  }

  @override
  Future<List<Vendedor>> syncVendedores() async {
    final localData = await localDatasource.getVendedores();

    try {
      final apiData = await apiDatasource.getVendedores();

      for (final elemento in apiData) {
        await localDatasource.saveVendedor(elemento);
      }

      return apiData;
    } catch (e) {
      return localData;
    }
  }

  @override
  Future<Almacen> getAlmacenById(int id) async {
    return localDatasource.getAlmacenById(id);
  }

  @override
  Future<List<Almacen>> getAlmacenByPage({int size = 10, int page = 0}) async {
    return localDatasource.getAlmacenesByPage(size: size, page: page);
  }

  @override
  Future<List<Almacen>> getAlmacenes() async {
    return localDatasource.getAlmacenes();
  }

  @override
  Future<List<Articulo>> getArticulos() async {
    return localDatasource.getArticulos();
  }

  @override
  Future<Articulo> getArticuloById(int id) async {
    return localDatasource.getArticuloById(id);
  }

  @override
  Future<List<Articulo>> getArticulosByPage(
      {int size = 10, int page = 0}) async {
    return localDatasource.getArticulosByPage(size: size, page: page);
  }

  @override
  Future<Cliente> getClienteById(int id) async {
    return localDatasource.getClienteById(id);
  }

  @override
  Future<List<Cliente>> getClientes() async {
    return localDatasource.getClientes();
  }

  @override
  Future<List<Cliente>> getClientesByPage({int size = 10, int page = 0}) async {
    return localDatasource.getClientesByPage(size: size, page: page);
  }

  @override
  Future<Cobrador> getCobradorById(int id) async {
    return localDatasource.getCobradorById(id);
  }

  @override
  Future<List<Cobrador>> getCobradores() async {
    return localDatasource.getCobradores();
  }

  @override
  Future<List<Cobrador>> getCobradoresByPage(
      {int size = 10, int page = 0}) async {
    return localDatasource.getCobradoresByPage(size: size, page: page);
  }

  @override
  Future<Moneda> getMonedaById(int id) async {
    return localDatasource.getMonedaById(id);
  }

  @override
  Future<List<Moneda>> getMonedas() async {
    return localDatasource.getMonedas();
  }

  @override
  Future<List<Moneda>> getMonedasByPage({int size = 10, int page = 0}) async {
    return localDatasource.getMonedasByPage(size: size, page: page);
  }

  @override
  Future<Sucursal> getSucursalById(int id) async {
    return localDatasource.getSucursalById(id);
  }

  @override
  Future<List<Sucursal>> getSucursales() async {
    return localDatasource.getSucursales();
  }

  @override
  Future<List<Sucursal>> getSucursalesByPage(
      {int size = 10, int page = 0}) async {
    return localDatasource.getSucursalesByPage(size: size, page: page);
  }

  @override
  Future<Vendedor> getVendedorById(int id) async {
    return localDatasource.getVendedorById(id);
  }

  @override
  Future<List<Vendedor>> getVendedores() async {
    return localDatasource.getVendedores();
  }

  @override
  Future<List<Vendedor>> getVendedoresByPage(
      {int size = 10, int page = 0}) async {
    return localDatasource.getVendedoresByPage(size: size, page: page);
  }

  @override
  Future<List<Almacen>> searchAlmacenesByTerm(String term) async {
    return localDatasource.searchAlmacenesByTerm(term);
  }

  @override
  Future<List<Articulo>> searchArticulosByTerm(String term) async {
    return localDatasource.searchArticulosByTerm(term);
  }

  @override
  Future<List<Cliente>> searchClientesByTerm(String term) async {
    return localDatasource.searchClientesByTerm(term);
  }

  @override
  Future<List<Cobrador>> searchCobradoresByTerm(String term) async {
    return localDatasource.searchCobradoresByTerm(term);
  }

  @override
  Future<List<Moneda>> searchMonedasByTerm(String term) async {
    return localDatasource.searchMonedasByTerm(term);
  }

  @override
  Future<List<Sucursal>> searchSucursalesByTerm(String term) async {
    return localDatasource.searchSucursalesByTerm(term);
  }

  @override
  Future<List<Vendedor>> searchVendedoresByTerm(String term) async {
    return localDatasource.searchVendedoresByTerm(term);
  }

  @override
  Future<CondicionPago> getCondicionPagoById(int id) {
    return localDatasource.getCondicionPagoById(id);
  }

  @override
  Future<List<CondicionPago>> getCondicionesPago() {
    return localDatasource.getCondicionesPago();
  }

  @override
  Future<List<CondicionPago>> getCondicionesPagoByPage(
      {int size = 10, int page = 0}) {
    return localDatasource.getCondicionesPagoByPage(size: size, page: page);
  }

  @override
  Future<List<CondicionPago>> searchCondicionesPagoByTerm(String term) {
    return localDatasource.searchCondicionesPagoByTerm(term);
  }

  @override
  Future<List<Pedido>> getPedidos() {
    return localDatasource.getPedidos();
  }
}
