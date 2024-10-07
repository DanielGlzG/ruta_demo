import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomdDrawer extends StatelessWidget {
  const CustomdDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            GestureDetector(
              onTap: () => context.push("/pedidos"),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Pedidos'),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.add_box),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () => context.push("/sucursales"),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Sucursales'),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.shop),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () => context.push("/vendedores"),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Vendedores'),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.people),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () => context.push("/cobradores"),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Cobradores'),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.point_of_sale_sharp),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () => context.push("/monedas"),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Monedas'),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.money),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () => context.push("/almacenes"),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Almacenes'),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.warehouse),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () => context.push("/condicionesPago"),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Condiciones Pago'),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.payment),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () => context.push("/articulos"),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Articulos'),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.online_prediction),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () => context.push("/clientes"),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Clientes'),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.nature_people_outlined),
                  ],
                ),
              ),
            ),
            // GestureDetector(
            //   onTap: () => context.push("/test"),
            //   child: const Padding(
            //     padding: EdgeInsets.all(8.0),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Text('Clientes'),
            //         SizedBox(
            //           width: 10,
            //         ),
            //         Icon(Icons.nature_people_outlined),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
