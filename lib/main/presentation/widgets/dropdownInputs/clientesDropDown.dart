import 'package:flutter/material.dart';

import '../../../domain/entities/entities.dart';

class ClientesDropdown extends StatefulWidget {
  final String label;
  final List<Cliente> clientes;
  final Cliente? initialValue;

  final void Function(int clienteId)? onChangeField;
  const ClientesDropdown(
      {required this.label,
      required this.clientes,
      this.onChangeField,
      this.initialValue});
  @override
  _DropdownMenuWidgetState createState() => _DropdownMenuWidgetState();
}

class _DropdownMenuWidgetState extends State<ClientesDropdown> {
  Cliente? selectedOption; // Variable para almacenar la opción seleccionada

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 10,
                offset: const Offset(0, 5))
          ]),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<Cliente>(
          isExpanded: true,
          value: selectedOption,
          hint: Text(
            widget.label,
          ),
          items: widget.clientes.map((Cliente value) {
            return DropdownMenuItem<Cliente>(
              value: value,
              child: Text(value.nombre),
            );
          }).toList(),
          onChanged: (Cliente? newValue) {
            if (newValue != null && widget.onChangeField != null) {
              setState(() {
                selectedOption = newValue;
              });
              widget.onChangeField!(newValue.id);
            }
          },
          dropdownColor: Colors.white, // Color del fondo del dropdown
          icon: const Icon(Icons.arrow_drop_down_circle),
        ),
      ),
    );
  }
}
