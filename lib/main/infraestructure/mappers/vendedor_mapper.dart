import 'package:ruta_demo/main/domain/entities/vendedor.dart';

class VendedorMapper {
  static Vendedor jsonToEntity(Map<String, dynamic> json) =>
      Vendedor(id: json['vendedorId'], nombre: json['nombre']);

  static Map<String, dynamic> entityToJson(Vendedor vendedor) => {
        'vendedorId': vendedor.id,
        'nombre': vendedor.nombre,
      };
}
