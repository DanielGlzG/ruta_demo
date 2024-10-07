import 'package:ruta_demo/config/db/sqliteDb.dart';
import 'package:ruta_demo/main/domain/datasources/microsip_datasource.dart';
import 'package:ruta_demo/main/domain/entities/entities.dart';
import 'package:ruta_demo/main/infraestructure/mappers/mappers.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatasource extends MicrosipDatasource {
  final database = SqliteDatasource.instance.database;

  Future<Map<String, dynamic>> _getById(String tabla, int id) async {
    try {
      final data = await database!.query(
        'articulos',
        where: 'id = ?',
        whereArgs: [id],
      );
      return data.first;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<int> saveArticulo(Articulo articulo) async {
    final db = await database;

    return await db!.insert(
      'articulos', // Nombre de la tabla
      ArticuloMapper.entityToJson(articulo), // Convertir el objeto a JSON
      conflictAlgorithm:
          ConflictAlgorithm.replace, // Reemplazar si el ID ya existe
    );
  }

  Future<int> saveAlmacen(Almacen almacen) async {
    final db = await database;
    return await db!.insert(
      'almacenes',
      AlmacenMapper.entityToJson(almacen),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> saveCliente(Cliente cliente) async {
    final db = await database;
    return await db!.insert(
      'clientes',
      ClienteMapper.entityToJson(cliente),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> saveCobrador(Cobrador cobrador) async {
    final db = await database;
    return await db!.insert(
      'cobradores',
      CobradorMapper.entityToJson(cobrador),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> saveMoneda(Moneda moneda) async {
    final db = await database;
    return await db!.insert(
      'monedas',
      MonedaMapper.entityToJson(moneda),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> saveSucursal(Sucursal sucursal) async {
    final db = await database;
    return await db!.insert(
      'sucursales',
      SucursalMapper.entityToJson(sucursal),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> saveVendedor(Vendedor vendedor) async {
    final db = await database;
    return await db!.insert(
      'vendedores',
      VendedorMapper.entityToJson(vendedor),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> saveCondicionPago(CondicionPago condicionPago) async {
    final db = await database;
    return await db!.insert(
      'condicionesPago',
      CondicionPagoMapper.entityToJson(condicionPago),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> savePedido(Pedido pedido) async {
    try {
      final db = await database;

      final a = PedidoMapper.entityToJson(pedido);
      print(a);
      return await db!.insert(
        'pedidos',
        PedidoMapper.entityToJson(pedido),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  Future eliminarPedido(Pedido pedido) async {
    final db = await database;

    await db!.delete(
      'pedidos',
      where: 'pedidoId = ?',
      whereArgs: [pedido.doctoVeId], // Aquí solo pasas el valor, no un map
    );
  }

  @override
  Future<List<Articulo>> getArticulos() async {
    try {
      final data = await database!.query('articulos');
      print('Hay localmente ${data.length} articulos');
      return data
          .map((articulo) => ArticuloMapper.jsonToEntity(articulo))
          .toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<Articulo>> getArticulosByPage(
      {int size = 10, int page = 0}) async {
    try {
      final data =
          await database!.query('articulos', limit: size, offset: page);

      return data.map((item) => ArticuloMapper.jsonToEntity(item)).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<Articulo> getArticuloById(int id) async {
    try {
      final elemento = await _getById('articulos', id);
      return ArticuloMapper.jsonToEntity(elemento);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Articulo>> searchArticulosByTerm(String term) async {
    final data = await database!.query('articulos');
    final articulos =
        data.map((articulo) => ArticuloMapper.jsonToEntity(articulo)).toList();

    return articulos.where((articulo) {
      return articulo.nombre.toLowerCase().contains(term.toLowerCase());
    }).toList();
  }

  @override
  Future<Almacen> getAlmacenById(int id) async {
    try {
      final elemento = await _getById('almacenes', id);
      return AlmacenMapper.jsonToEntity(elemento);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Almacen>> getAlmacenes() async {
    try {
      final data = await database!.query('almacenes');
      print('Hay localmente ${data.length} almacenes');
      return data.map((item) => AlmacenMapper.jsonToEntity(item)).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<Almacen>> getAlmacenesByPage(
      {int size = 10, int page = 0}) async {
    try {
      final data =
          await database!.query('almacenes', limit: size, offset: page);

      return data.map((item) => AlmacenMapper.jsonToEntity(item)).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<Cliente> getClienteById(int id) async {
    try {
      final elemento = await _getById('clientes', id);
      return ClienteMapper.jsonToEntity(elemento);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Cliente>> getClientes() async {
    try {
      final data = await database!.query('clientes');
      print('Hay localmente ${data.length} clientes');
      return data.map((item) => ClienteMapper.jsonToEntity(item)).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<Cliente>> getClientesByPage({int size = 10, int page = 0}) async {
    try {
      final data = await database!.query('clientes', limit: size, offset: page);

      return data.map((item) => ClienteMapper.jsonToEntity(item)).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<Cobrador> getCobradorById(int id) async {
    try {
      final elemento = await _getById('cobradores', id);
      return CobradorMapper.jsonToEntity(elemento);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Cobrador>> getCobradores() async {
    try {
      final data = await database!.query('cobradores');
      print('Hay localmente ${data.length} cobradores');
      return data.map((item) => CobradorMapper.jsonToEntity(item)).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<Cobrador>> getCobradoresByPage(
      {int size = 10, int page = 0}) async {
    try {
      final data =
          await database!.query('cobradores', limit: size, offset: page);

      return data.map((item) => CobradorMapper.jsonToEntity(item)).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<Moneda> getMonedaById(int id) async {
    try {
      final elemento = await _getById('monedas', id);
      return MonedaMapper.jsonToEntity(elemento);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Moneda>> getMonedas() async {
    try {
      final data = await database!.query('monedas');
      print('Hay localmente ${data.length} monedas');
      return data.map((item) => MonedaMapper.jsonToEntity(item)).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<Moneda>> getMonedasByPage({int size = 10, int page = 0}) async {
    try {
      final data = await database!.query('monedas', limit: size, offset: page);

      return data.map((item) => MonedaMapper.jsonToEntity(item)).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<Sucursal> getSucursalById(int id) async {
    try {
      final elemento = await _getById('sucursales', id);
      return SucursalMapper.jsonToEntity(elemento);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Sucursal>> getSucursales() async {
    try {
      final data = await database!.query('sucursales');
      print('Hay localmente ${data.length} sucursales');
      return data.map((item) => SucursalMapper.jsonToEntity(item)).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<Sucursal>> getSucursalesByPage(
      {int size = 10, int page = 0}) async {
    try {
      final data =
          await database!.query('sucursales', limit: size, offset: page);

      return data.map((item) => SucursalMapper.jsonToEntity(item)).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<Vendedor> getVendedorById(int id) async {
    try {
      final elemento = await _getById('vendedores', id);
      return VendedorMapper.jsonToEntity(elemento);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Vendedor>> getVendedores() async {
    try {
      final data = await database!.query('vendedores');
      print('Hay localmente ${data.length} vendedores');
      return data.map((item) => VendedorMapper.jsonToEntity(item)).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<Vendedor>> getVendedoresByPage(
      {int size = 10, int page = 0}) async {
    try {
      final data =
          await database!.query('vendedores', limit: size, offset: page);

      return data.map((item) => VendedorMapper.jsonToEntity(item)).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<Almacen>> searchAlmacenesByTerm(String term) async {
    final data = await database!.query('almacenes');
    final almacenes =
        data.map((almacen) => AlmacenMapper.jsonToEntity(almacen)).toList();

    return almacenes.where((almacen) {
      return almacen.nombre.toLowerCase().contains(term.toLowerCase());
    }).toList();
  }

  @override
  Future<List<Cliente>> searchClientesByTerm(String term) async {
    final data = await database!.query('clientes');
    final clientes =
        data.map((cliente) => ClienteMapper.jsonToEntity(cliente)).toList();

    return clientes.where((cliente) {
      return cliente.nombre.toLowerCase().contains(term.toLowerCase());
    }).toList();
  }

  @override
  Future<List<Cobrador>> searchCobradoresByTerm(String term) async {
    final data = await database!.query('cobradores');
    final cobradores =
        data.map((cobrador) => CobradorMapper.jsonToEntity(cobrador)).toList();

    return cobradores.where((cobrador) {
      return cobrador.nombre.toLowerCase().contains(term.toLowerCase());
    }).toList();
  }

  @override
  Future<List<Moneda>> searchMonedasByTerm(String term) async {
    final data = await database!.query('monedas');
    final monedas =
        data.map((moneda) => MonedaMapper.jsonToEntity(moneda)).toList();

    return monedas.where((moneda) {
      return moneda.nombre.toLowerCase().contains(term.toLowerCase());
    }).toList();
  }

  @override
  Future<List<Sucursal>> searchSucursalesByTerm(String term) async {
    final data = await database!.query('sucursales');
    final sucursales =
        data.map((sucursal) => SucursalMapper.jsonToEntity(sucursal)).toList();

    return sucursales.where((sucursal) {
      return sucursal.nombre.toLowerCase().contains(term.toLowerCase());
    }).toList();
  }

  @override
  Future<List<Vendedor>> searchVendedoresByTerm(String term) async {
    final data = await database!.query('vendedores');
    final vendedores =
        data.map((vendedor) => VendedorMapper.jsonToEntity(vendedor)).toList();

    return vendedores.where((vendedor) {
      return vendedor.nombre.toLowerCase().contains(term.toLowerCase());
    }).toList();
  }

  @override
  Future<CondicionPago> getCondicionPagoById(int id) async {
    try {
      final elemento = await _getById('condicionesPago', id);
      return CondicionPagoMapper.jsonToEntity(elemento);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<CondicionPago>> getCondicionesPago() async {
    try {
      final data = await database!.query('condicionesPago');
      print('Hay localmente ${data.length} condicionesPago');
      return data
          .map((item) => CondicionPagoMapper.jsonToEntity(item))
          .toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<CondicionPago>> getCondicionesPagoByPage(
      {int size = 10, int page = 0}) async {
    try {
      final data =
          await database!.query('condicionesPago', limit: size, offset: page);

      return data
          .map((item) => CondicionPagoMapper.jsonToEntity(item))
          .toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<CondicionPago>> searchCondicionesPagoByTerm(String term) async {
    final data = await database!.query('condicionesPago');
    final condicionesPago = data
        .map((condicionPago) => CondicionPagoMapper.jsonToEntity(condicionPago))
        .toList();

    return condicionesPago.where((condicionPago) {
      return condicionPago.nombre.toLowerCase().contains(term.toLowerCase());
    }).toList();
  }

  Future<List<Pedido>> getPedidos() async {
    try {
      final data = await database!.query('pedidos');
      print('Hay localmente ${data.length} pedidos');
      return data.map((item) => PedidoMapper.jsonToEntity(item)).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future enviarPedido(Pedido pedido) {
    throw UnimplementedError();
  }
}
