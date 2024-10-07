import '../entities/entities.dart';

abstract class MicrosipRepository {
  // ARTICULOS

  Future<List<Articulo>> getArticulosByPage({int size = 10, int page = 0});
  Future<List<Articulo>> getArticulos();
  Future<Articulo> getArticuloById(int id);
  Future<List<Articulo>> searchArticulosByTerm(String term);

  // ALMACENES

  Future<List<Almacen>> getAlmacenByPage({int size = 10, int page = 0});
  Future<List<Almacen>> getAlmacenes();
  Future<Almacen> getAlmacenById(int id);
  Future<List<Almacen>> searchAlmacenesByTerm(String term);

  // CLIENTES

  Future<List<Cliente>> getClientesByPage({int size = 10, int page = 0});
  Future<List<Cliente>> getClientes();
  Future<Cliente> getClienteById(int id);
  Future<List<Cliente>> searchClientesByTerm(String term);

  // COBRADORES

  Future<List<Cobrador>> getCobradoresByPage({int size = 10, int page = 0});
  Future<List<Cobrador>> getCobradores();
  Future<Cobrador> getCobradorById(int id);
  Future<List<Cobrador>> searchCobradoresByTerm(String term);

  // MONEDAS

  Future<List<Moneda>> getMonedasByPage({int size = 10, int page = 0});
  Future<List<Moneda>> getMonedas();
  Future<Moneda> getMonedaById(int id);
  Future<List<Moneda>> searchMonedasByTerm(String term);

  // PEDIDOS

  Future enviarPedido(Pedido pedido);

  // SUCURSALES

  Future<List<Sucursal>> getSucursalesByPage({int size = 10, int page = 0});
  Future<List<Sucursal>> getSucursales();
  Future<Sucursal> getSucursalById(int id);
  Future<List<Sucursal>> searchSucursalesByTerm(String term);

  // VENDEDORES

  Future<List<Vendedor>> getVendedoresByPage({int size = 10, int page = 0});
  Future<List<Vendedor>> getVendedores();
  Future<Vendedor> getVendedorById(int id);
  Future<List<Vendedor>> searchVendedoresByTerm(String term);

  // CONDICIONES PAGO

  Future<List<CondicionPago>> getCondicionesPagoByPage(
      {int size = 10, int page = 0});
  Future<List<CondicionPago>> getCondicionesPago();
  Future<CondicionPago> getCondicionPagoById(int id);
  Future<List<CondicionPago>> searchCondicionesPagoByTerm(String term);
}
