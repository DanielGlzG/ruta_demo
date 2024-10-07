import 'package:ruta_demo/main/domain/entities/cliente.dart';

class ClienteMapper {
  static Cliente jsonToEntity(Map<String, dynamic> json) => Cliente(
      id: json['clienteId'],
      monedaId: json['monedaId'],
      nombre: json['nombre'],
      cobradorId: json['cobradorId'],
      vendedorId: json['vendedorid']);

  static Map<String, dynamic> entityToJson(Cliente cliente) => {
        'monedaId': cliente.monedaId,
        'nombre': cliente.nombre,
        'clienteId': cliente.id,
        'cobradorId': cliente.cobradorId,
        'vendedorId': cliente.vendedorId
      };
}
