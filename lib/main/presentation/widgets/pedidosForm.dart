import 'package:flutter/material.dart';

class Pedidosform extends StatefulWidget {
  const Pedidosform({super.key});

  @override
  State<Pedidosform> createState() => _PedidosformState();
}

class Producto {
  final int id;
  final String nombre;
  final int cantidad;
  final double precio;

  Producto(
      {required this.id,
      required this.nombre,
      required this.cantidad,
      required this.precio});
}

class _PedidosformState extends State<Pedidosform> {
  List<Producto> productos = [];
  Producto productoActual = Producto(id: 0, nombre: '', cantidad: 0, precio: 0);
  bool modoEdicion = false;
  bool dialogoAbierto = false;
  Map<String, String> datosVenta = {
    'nombreCliente': '',
    'email': '',
    'telefono': '',
    'fechaVenta': '',
    'metodoPago': '',
    'numeroFactura': '',
  };

  void guardarProducto() {
    if (productoActual.nombre.isNotEmpty &&
        productoActual.cantidad > 0 &&
        productoActual.precio > 0) {
      setState(() {
        if (modoEdicion) {
          productos = productos
              .map((p) => p.id == productoActual.id ? productoActual : p)
              .toList();
        } else {
          productos.add(Producto(
            id: DateTime.now().millisecondsSinceEpoch,
            nombre: productoActual.nombre,
            cantidad: productoActual.cantidad,
            precio: productoActual.precio,
          ));
        }
        productoActual = Producto(id: 0, nombre: '', cantidad: 0, precio: 0);
        modoEdicion = false;
        dialogoAbierto = false;
      });
    }
  }

  void editarProducto(Producto producto) {
    setState(() {
      productoActual = producto;
      modoEdicion = true;
      dialogoAbierto = true;
    });
  }

  void eliminarProducto(int id) {
    setState(() {
      productos = productos.where((p) => p.id != id).toList();
    });
  }

  void handleInputChange(String key, String value) {
    setState(() {
      datosVenta[key] = value;
    });
  }

  double calcularTotal() {
    return productos.fold(
        0.0, (total, producto) => total + producto.cantidad * producto.precio);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Formulario de Venta")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            child: Column(
              children: [
                datosVentaCard(),
                productosCard(),
                totalVentaCard(),
                submitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget datosVentaCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Nombre del Cliente'),
              onChanged: (value) => handleInputChange('nombreCliente', value),
              controller:
                  TextEditingController(text: datosVenta['nombreCliente']),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Correo Electrónico'),
              onChanged: (value) => handleInputChange('email', value),
              controller: TextEditingController(text: datosVenta['email']),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Teléfono'),
              onChanged: (value) => handleInputChange('telefono', value),
              controller: TextEditingController(text: datosVenta['telefono']),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Fecha de Venta'),
              onChanged: (value) => handleInputChange('fechaVenta', value),
              controller: TextEditingController(text: datosVenta['fechaVenta']),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Método de Pago'),
              onChanged: (value) => handleInputChange('metodoPago', value),
              controller: TextEditingController(text: datosVenta['metodoPago']),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Número de Factura'),
              onChanged: (value) => handleInputChange('numeroFactura', value),
              controller:
                  TextEditingController(text: datosVenta['numeroFactura']),
            ),
          ],
        ),
      ),
    );
  }

  Widget productosCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var producto in productos)
              ListTile(
                title: Text(producto.nombre),
                subtitle: Text(
                    "Cantidad: ${producto.cantidad} | Precio: \$${producto.precio.toStringAsFixed(2)}"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () => editarProducto(producto),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => eliminarProducto(producto.id),
                    ),
                  ],
                ),
              ),
            ElevatedButton(
              onPressed: () => setState(() {
                productoActual =
                    Producto(id: 0, nombre: '', cantidad: 0, precio: 0);
                modoEdicion = false;
                dialogoAbierto = !dialogoAbierto;
              }),
              child: Text(modoEdicion ? 'Editar Producto' : 'Agregar Producto'),
            ),
            if (dialogoAbierto) productoDialog(),
          ],
        ),
      ),
    );
  }

  Widget productoDialog() {
    return AlertDialog(
      title: Text(modoEdicion ? 'Editar Producto' : 'Agregar Producto'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: InputDecoration(labelText: 'Nombre'),
            onChanged: (value) {},
            controller: TextEditingController(text: productoActual.nombre),
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Cantidad'),
            onChanged: (value) {},
            keyboardType: TextInputType.number,
            controller:
                TextEditingController(text: productoActual.cantidad.toString()),
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Precio'),
            onChanged: (value) {},
            keyboardType: TextInputType.number,
            controller:
                TextEditingController(text: productoActual.precio.toString()),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: Text('Cancelar'),
          onPressed: () => setState(() => dialogoAbierto = false),
        ),
        TextButton(
          child: Text('Guardar'),
          onPressed: guardarProducto,
        ),
      ],
    );
  }

  Widget totalVentaCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'Total de la Venta: \$${calcularTotal().toStringAsFixed(2)}',
        ),
      ),
    );
  }

  Widget submitButton() {
    return ElevatedButton(
      onPressed: () {
        print('Datos de venta: $datosVenta');
        print('Productos: $productos');
        print('Total de la venta: \$${calcularTotal()}');
        // Aquí iría la lógica para procesar la venta
      },
      child: Text('Finalizar Venta'),
    );
  }
}
