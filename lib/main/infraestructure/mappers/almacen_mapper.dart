import 'package:ruta_demo/main/domain/entities/almacen.dart';

class AlmacenMapper {
  static Almacen jsonToEntity(Map<String, dynamic> json) => Almacen(
      id: json['almacenId'],
      nombre: json['nombre'],
      nombreAbrev: json['nombreAbrev']);

  static Map<String, dynamic> entityToJson(Almacen almacen) => {
        'almacenId': almacen.id,
        'nombre': almacen.nombre,
        'nombreAbrev': almacen.nombreAbrev
      };
}
