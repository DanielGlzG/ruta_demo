import 'package:ruta_demo/main/domain/entities/moneda.dart';

class MonedaMapper {
  static Moneda jsonToEntity(Map<String, dynamic> json) => Moneda(
      id: json['monedaId'],
      nombre: json['nombre'],
      simbolo: json['simbolo'],
      claveFiscal: json['claveFiscal']);

  static Map<String, dynamic> entityToJson(Moneda moneda) => {
        'monedaId': moneda.id,
        'nombre': moneda.nombre,
        'simbolo': moneda.simbolo,
        'claveFiscal': moneda.claveFiscal
      };
}
