class Cliente {
  final int id;
  final String nombre;
  final int? monedaId;
  final int? cobradorId;
  final int? vendedorId;

  Cliente({
    required this.monedaId,
    required this.nombre,
    required this.id,
    required this.cobradorId,
    required this.vendedorId,
  });
}
