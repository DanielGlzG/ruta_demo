import 'package:ruta_demo/main/domain/entities/articulo.dart';

class ArticuloMapper {
  static Articulo jsonToEntity(Map<String, dynamic> json) => Articulo(
      id: json['articuloId'], nombre: json['nombre'], status: json['estatus']);

  static Map<String, dynamic> entityToJson(Articulo articulo) => {
        'articuloId': articulo.id,
        'nombre': articulo.nombre,
        'estatus': articulo.status
      };
}
