import 'package:dio/dio.dart';
import 'package:ruta_demo/main/infraestructure/mappers/mappers.dart';
import '../../../config/constants/environment.dart';
import '../../domain/datasources/microsip_datasource.dart';
import '../../domain/entities/entities.dart';

class ApiMicrosipDatasourceImpl extends MicrosipDatasource {
  late final Dio dio;

  ApiMicrosipDatasourceImpl()
      : dio = Dio(BaseOptions(baseUrl: Environment.apiUrl));

  @override
  Future<Almacen> getAlmacenById(int id) async {
    try {
      final response = await dio.get("/almacenes/$id");
      return AlmacenMapper.jsonToEntity(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Almacen>> getAlmacenes() async {
    try {
      final response = await dio.get("/almacenes/all");

      final List<Almacen> items = [];
      print('La api arrojo ${response.data.length} almacenes');

      for (final item in response.data ?? []) {
        items.add(AlmacenMapper.jsonToEntity(item));
      }
      return items;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Almacen>> getAlmacenesByPage(
      {int size = 10, int page = 0}) async {
    try {
      final response = await dio
          .get("/almacenes", queryParameters: {'size': size, 'page': page});

      final List<Almacen> almacenes = [];

      for (final almacen in response.data['content'] ?? []) {
        almacenes.add(AlmacenMapper.jsonToEntity(almacen));
      }
      return almacenes;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Articulo> getArticuloById(int id) async {
    try {
      final response = await dio.get("/articulos/$id");
      return ArticuloMapper.jsonToEntity(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Articulo>> getArticulos() async {
    try {
      final response = await dio.get("/articulos/all");

      final List<Articulo> items = [];
      print('La api arrojo ${response.data.length} articulos');

      for (final item in response.data ?? []) {
        items.add(ArticuloMapper.jsonToEntity(item));
      }
      return items;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Articulo>> getArticulosByPage(
      {int size = 10, int page = 0}) async {
    try {
      final response = await dio
          .get("/articulos", queryParameters: {'size': size, 'page': page});

      final List<Articulo> articulos = [];

      for (final articulo in response.data['content'] ?? []) {
        articulos.add(ArticuloMapper.jsonToEntity(articulo));
      }
      return articulos;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Cliente> getClienteById(int id) async {
    try {
      final response = await dio.get("/clientes/$id");
      return ClienteMapper.jsonToEntity(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Cliente>> getClientes() async {
    try {
      final response = await dio.get("/clientes/all");

      final List<Cliente> items = [];
      print('La api arrojo ${response.data.length} clientes');

      for (final item in response.data ?? []) {
        items.add(ClienteMapper.jsonToEntity(item));
      }
      return items;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Cliente>> getClientesByPage({int size = 10, int page = 0}) async {
    try {
      final response = await dio
          .get("/clientes", queryParameters: {'size': size, 'page': page});

      final List<Cliente> clientes = [];

      for (final cliente in response.data['content'] ?? []) {
        clientes.add(ClienteMapper.jsonToEntity(cliente));
      }
      return clientes;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Cobrador> getCobradorById(int id) async {
    try {
      final response = await dio.get("/cobradores/$id");
      return CobradorMapper.jsonToEntity(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Cobrador>> getCobradores() async {
    try {
      final response = await dio.get("/cobradores/all");

      final List<Cobrador> items = [];
      print('La api arrojo ${response.data.length} cobradores');

      for (final item in response.data ?? []) {
        items.add(CobradorMapper.jsonToEntity(item));
      }
      return items;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Cobrador>> getCobradoresByPage(
      {int size = 10, int page = 0}) async {
    try {
      final response = await dio
          .get("/cobradores", queryParameters: {'size': size, 'page': page});

      final List<Cobrador> cobradores = [];

      for (final cobrador in response.data['content'] ?? []) {
        cobradores.add(CobradorMapper.jsonToEntity(cobrador));
      }
      return cobradores;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Moneda> getMonedaById(int id) async {
    try {
      final response = await dio.get("/monedas/$id");
      return MonedaMapper.jsonToEntity(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Moneda>> getMonedas() async {
    try {
      final response = await dio.get("/monedas/all");

      final List<Moneda> items = [];
      print('La api arrojo ${response.data.length} monedas');

      for (final item in response.data ?? []) {
        items.add(MonedaMapper.jsonToEntity(item));
      }
      return items;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Moneda>> getMonedasByPage({int size = 10, int page = 0}) async {
    try {
      final response = await dio
          .get("/monedas", queryParameters: {'size': size, 'page': page});

      final List<Moneda> monedas = [];

      for (final moneda in response.data['content'] ?? []) {
        monedas.add(MonedaMapper.jsonToEntity(moneda));
      }
      return monedas;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Sucursal> getSucursalById(int id) async {
    try {
      final response = await dio.get("/sucursales/$id");
      return SucursalMapper.jsonToEntity(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Sucursal>> getSucursales() async {
    try {
      final response = await dio.get("/sucursales/all");

      final List<Sucursal> items = [];
      print('La api arrojo ${response.data.length} sucursales');

      for (final item in response.data ?? []) {
        items.add(SucursalMapper.jsonToEntity(item));
      }
      return items;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Sucursal>> getSucursalesByPage(
      {int size = 10, int page = 0}) async {
    try {
      final response = await dio
          .get("/sucursales", queryParameters: {'size': size, 'page': page});

      final List<Sucursal> sucursales = [];

      for (final sucursal in response.data['content'] ?? []) {
        sucursales.add(SucursalMapper.jsonToEntity(sucursal));
      }
      return sucursales;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Vendedor> getVendedorById(int id) async {
    try {
      final response = await dio.get("/vendedores/$id");
      return VendedorMapper.jsonToEntity(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Vendedor>> getVendedores() async {
    try {
      final response = await dio.get("/vendedores/all");

      final List<Vendedor> items = [];
      print('La api arrojo ${response.data.length} vendedores');

      for (final item in response.data ?? []) {
        items.add(VendedorMapper.jsonToEntity(item));
      }
      return items;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Vendedor>> getVendedoresByPage(
      {int size = 10, int page = 0}) async {
    try {
      final response = await dio
          .get("/vendedores", queryParameters: {'size': size, 'page': page});

      final List<Vendedor> vendedores = [];

      for (final vendedor in response.data['content'] ?? []) {
        vendedores.add(VendedorMapper.jsonToEntity(vendedor));
      }
      return vendedores;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Almacen>> searchAlmacenesByTerm(String term) async {
    try {
      final response =
          await dio.get("/almacenes/search", queryParameters: {'term': term});

      final List<Almacen> almacenes = [];

      for (final almacen in response.data ?? []) {
        almacenes.add(AlmacenMapper.jsonToEntity(almacen));
      }
      return almacenes;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Articulo>> searchArticulosByTerm(String term) async {
    try {
      final response =
          await dio.get("/articulos/search", queryParameters: {'term': term});

      final List<Articulo> articulos = [];

      for (final articulo in response.data ?? []) {
        articulos.add(ArticuloMapper.jsonToEntity(articulo));
      }
      return articulos;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Cliente>> searchClientesByTerm(String term) async {
    try {
      final response =
          await dio.get("/clientes/search", queryParameters: {'term': term});

      final List<Cliente> clientes = [];

      for (final cliente in response.data ?? []) {
        clientes.add(ClienteMapper.jsonToEntity(cliente));
      }
      return clientes;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Cobrador>> searchCobradoresByTerm(String term) async {
    try {
      final response =
          await dio.get("/cobradores/search", queryParameters: {'term': term});

      final List<Cobrador> cobradores = [];

      for (final cobrador in response.data ?? []) {
        cobradores.add(CobradorMapper.jsonToEntity(cobrador));
      }
      return cobradores;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Moneda>> searchMonedasByTerm(String term) async {
    try {
      final response =
          await dio.get("/monedas/search", queryParameters: {'term': term});

      final List<Moneda> monedas = [];

      for (final moneda in response.data ?? []) {
        monedas.add(MonedaMapper.jsonToEntity(moneda));
      }
      return monedas;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Sucursal>> searchSucursalesByTerm(String term) async {
    try {
      final response =
          await dio.get("/sucursales/search", queryParameters: {'term': term});

      final List<Sucursal> sucursales = [];

      for (final sucursal in response.data ?? []) {
        sucursales.add(SucursalMapper.jsonToEntity(sucursal));
      }
      return sucursales;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Vendedor>> searchVendedoresByTerm(String term) async {
    try {
      final response =
          await dio.get("/vendedores/search", queryParameters: {'term': term});

      final List<Vendedor> vendedores = [];

      for (final vendedor in response.data ?? []) {
        vendedores.add(VendedorMapper.jsonToEntity(vendedor));
      }
      return vendedores;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<CondicionPago> getCondicionPagoById(int id) async {
    try {
      final response = await dio.get("/condiciones-pago/$id");
      return CondicionPagoMapper.jsonToEntity(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<CondicionPago>> getCondicionesPago() async {
    try {
      final response = await dio.get("/condiciones-pago/all");

      final List<CondicionPago> items = [];
      print('La api arrojo ${response.data.length} condiciones de pago');

      for (final item in response.data ?? []) {
        items.add(CondicionPagoMapper.jsonToEntity(item));
      }
      return items;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<CondicionPago>> getCondicionesPagoByPage(
      {int size = 10, int page = 0}) async {
    try {
      final response = await dio.get("/condiciones-pago",
          queryParameters: {'size': size, 'page': page});

      final List<CondicionPago> condicionesPago = [];

      for (final condicionPago in response.data['content'] ?? []) {
        condicionesPago.add(CondicionPagoMapper.jsonToEntity(condicionPago));
      }
      return condicionesPago;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<CondicionPago>> searchCondicionesPagoByTerm(String term) async {
    try {
      final response = await dio
          .get("/condiciones-pago/search", queryParameters: {'term': term});

      final List<CondicionPago> condicionesPago = [];

      for (final condicionPago in response.data ?? []) {
        condicionesPago.add(CondicionPagoMapper.jsonToEntity(condicionPago));
      }
      return condicionesPago;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future enviarPedido(Pedido pedido) async {
    try {
      await dio.post("/doctos-ve", data: PedidoMapper.entityToJson(pedido));
    } catch (e) {
      throw Exception(e);
    }
  }
}
