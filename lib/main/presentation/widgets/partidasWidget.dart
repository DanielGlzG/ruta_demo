import 'package:ruta_demo/main/presentation/widgets/dropdownInputs/ArticulosDropDown.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/entities.dart';

class PartidaPedido {
  int doctoVeDetId;
  String? claveArticulo; // Acepta nulos
  int articuloId;
  double unidades;
  double unidadesComprom;
  double unidadesSurtDev;
  double unidadesASurtir;
  double precioUnitario;
  double pctjeDscto;
  double pctjeDsctoCli;
  double dsctoArt;
  double dsctoExtra;
  double pctjeDsctoVol;
  double pctjeDsctoPromo;
  double precioTotalNeto;
  double pctjeComis;
  String rol;
  String? notas; // Acepta nulos
  String? terceroCoId; // Acepta nulos
  int posicion;

  // Constructor con valores por defecto y parámetros opcionales
  PartidaPedido({
    this.doctoVeDetId = -1,
    this.claveArticulo,
    required this.articuloId,
    required this.unidades,
    this.unidadesComprom = 0.0,
    this.unidadesSurtDev = 0.0,
    this.unidadesASurtir = 0.0,
    this.precioUnitario = 0.0,
    this.pctjeDscto = 0.0,
    this.pctjeDsctoCli = 0.0,
    this.dsctoArt = 0.0,
    this.dsctoExtra = 0.0,
    this.pctjeDsctoVol = 0.0,
    this.pctjeDsctoPromo = 0.0,
    this.precioTotalNeto = 0.0,
    this.pctjeComis = 0.0,
    this.rol = 'N',
    this.notas,
    this.terceroCoId,
    this.posicion = 1,
  });
}

class ItemsForm extends StatefulWidget {
  final List<Articulo> articulos;
  final void Function(List<PartidaPedido> partidas)? onChangeField;
  const ItemsForm({super.key, required this.articulos, this.onChangeField});
  @override
  _ItemsFormState createState() => _ItemsFormState();
}

class _ItemsFormState extends State<ItemsForm> {
  List<PartidaPedido> items = [];

  // Función para agregar un nuevo ítem
  void addItem() {
    setState(() {
      items.add(PartidaPedido(articuloId: 1, unidades: 1));
    });
    if (widget.onChangeField != null) {
      widget.onChangeField!(items);
    }
  }

  // Función para manejar cambios en el campo de nombre o cantidad
  void handleInputChange(int index, String field, dynamic value) {
    setState(() {
      if (field == 'articulo') {
        items[index].articuloId = value;
      } else if (field == 'cantidad') {
        items[index].unidades = value;
      }
    });
    if (widget.onChangeField != null) {
      widget.onChangeField!(items);
    }
  }

  // Función para eliminar un ítem
  void removeItem(int index) {
    setState(() {
      items.removeAt(index);
    });
    if (widget.onChangeField != null) {
      widget.onChangeField!(items);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Items',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          // Mapeo de la lista de ítems a TextFields
          ListView.builder(
            shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  // Campo de texto para el nombre del ítem
                  Expanded(
                    child: ArticulosDropdown(
                      label: 'Articulos',
                      articulos: widget.articulos,
                      onChangeField: (value) =>
                          handleInputChange(index, 'articulo', value),
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Campo de texto para la cantidad
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: 'Quantity',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) => handleInputChange(
                          index, 'cantidad', int.tryParse(value) ?? 0),
                      controller: TextEditingController(
                          text: items[index].unidades.toString()),
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Botón para eliminar el ítem
                  IconButton(
                    onPressed: () => removeItem(index),
                    icon: const Icon(Icons.delete, color: Colors.red),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 10),
          // Botón para agregar un nuevo ítem
          OutlinedButton.icon(
            onPressed: addItem,
            icon: const Icon(Icons.add),
            label: const Text('Add Item'),
          ),
        ],
      ),
    );
  }
}
