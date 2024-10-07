import 'package:ruta_demo/main/domain/entities/sucursal.dart';

class SucursalMapper {
  static Sucursal jsonToEntity(Map<String, dynamic> json) => Sucursal(
      id: json['sucursalId'],
      nombre: json['nombre'],
      nombreAbrev: json['nombreAbrev']);

  static Map<String, dynamic> entityToJson(Sucursal sucursal) => {
        'sucursalId': sucursal.id,
        'nombre': sucursal.nombre,
        'nombreAbrev': sucursal.nombreAbrev
      };
}
