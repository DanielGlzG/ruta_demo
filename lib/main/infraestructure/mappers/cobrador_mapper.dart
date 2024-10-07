import 'package:ruta_demo/main/domain/entities/cobrador.dart';

class CobradorMapper {
  static Cobrador jsonToEntity(Map<String, dynamic> json) =>
      Cobrador(id: json['cobradorId'], nombre: json['nombre']);

  static Map<String, dynamic> entityToJson(Cobrador cobrador) => {
        'cobradorId': cobrador.id,
        'nombre': cobrador.nombre,
      };
}
