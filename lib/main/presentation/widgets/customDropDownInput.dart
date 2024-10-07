import 'package:flutter/material.dart';

class CustomDropDownInput<T> extends StatefulWidget {
  final String title; // Parámetro para recibir el título
  final List<T> values; // Lista de objetos genéricos
  final String Function(T)
      displayProperty; // Función para acceder al nombre de la opción

  const CustomDropDownInput({
    super.key,
    required this.title,
    required this.values,
    required this.displayProperty, // Función para obtener el nombre
  });

  @override
  State<CustomDropDownInput> createState() => _CustomDropDownInputState<T>();
}

class _CustomDropDownInputState<T> extends State<CustomDropDownInput<T>> {
  T? _selectedValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Muestra el título recibido como parámetro
        Text(
          widget.title, // Accede al título pasado como parámetro
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
            height: 8), // Añade un espacio entre el título y el dropdown
        DropdownButton<T>(
          hint: const Text('Selecciona una opción'),
          value: _selectedValue,
          items: widget.values.map((T option) {
            return DropdownMenuItem<T>(
              value: option,
              child: Text(widget
                  .displayProperty(option)), // Muestra la propiedad del objeto
            );
          }).toList(),
          onChanged: (T? newValue) {
            setState(() {
              _selectedValue = newValue;
            });
          },
        ),
      ],
    );
  }
}
