import 'package:ruta_demo/main/domain/entities/condicionPago.dart';

class CondicionPagoMapper {
  static CondicionPago jsonToEntity(Map<String, dynamic> json) =>
      CondicionPago(id: json['condPagoId'], nombre: json['nombre']);

  static Map<String, dynamic> entityToJson(CondicionPago cobrador) => {
        'condPagoId': cobrador.id,
        'nombre': cobrador.nombre,
      };
}
