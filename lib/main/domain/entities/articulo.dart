class Articulo {
  int id;
  String nombre;
  String status;

  Articulo({required this.id, required this.nombre, required this.status});

  Articulo copyWith({int? id, String? nombre, String? status}) => Articulo(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      status: status ?? this.status);
}
