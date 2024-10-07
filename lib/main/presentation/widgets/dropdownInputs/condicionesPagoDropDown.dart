import 'package:flutter/material.dart';

import '../../../domain/entities/entities.dart';

class CondicionesPagoDropdown extends StatefulWidget {
  final String label;
  final List<CondicionPago> condicionesPago;
  final CondicionPago? initialValue;

  final void Function(int id)? onChangeField;
  const CondicionesPagoDropdown(
      {required this.label,
      required this.condicionesPago,
      this.onChangeField,
      this.initialValue});
  @override
  _DropdownMenuWidgetState createState() => _DropdownMenuWidgetState();
}

class _DropdownMenuWidgetState extends State<CondicionesPagoDropdown> {
  CondicionPago?
      selectedOption; // Variable para almacenar la opción seleccionada

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
        child: DropdownButton<CondicionPago>(
          isExpanded: true,
          value: selectedOption,
          hint: Text(
            widget.label,
          ),
          items: widget.condicionesPago.map((CondicionPago value) {
            return DropdownMenuItem<CondicionPago>(
              value: value,
              child: Text(value.nombre),
            );
          }).toList(),
          onChanged: (CondicionPago? newValue) {
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
