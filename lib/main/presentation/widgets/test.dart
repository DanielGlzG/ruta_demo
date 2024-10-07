import 'package:ruta_demo/main/domain/entities/entities.dart';
import 'package:flutter/material.dart';

class ClientList extends StatefulWidget {
  final List<Cliente> clientes;

  const ClientList({super.key, required this.clientes});

  @override
  _ClientListState createState() => _ClientListState();
}

class _ClientListState extends State<ClientList> {
  String searchTerm = '';

  @override
  Widget build(BuildContext context) {
    List<Cliente> filteredClients = widget.clientes.where((cliente) {
      return cliente.nombre.toLowerCase().contains(searchTerm.toLowerCase()) ||
          cliente.id
              .toString()
              .toLowerCase()
              .contains(searchTerm.toLowerCase());
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: ' Buscar Clientes',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors
                            .black) // Borde negro cuando el campo está inactivo
                    ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.black,
                        width:
                            2.0) // Borde negro más grueso cuando el campo está activo
                    ),
              ),
              onChanged: (value) {
                setState(() {
                  searchTerm = value;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredClients.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ListTile(
                    title: Text(filteredClients[index].nombre),
                    trailing: Text(
                      filteredClients[index].id.toString(),
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    onTap: () {
                      // Handle client selection
                      print('Selected client ID: ${filteredClients[index].id}');
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Client {
  final String id;
  final String name;
  final String address;
  final double balance;

  Client(this.id, this.name, this.address, this.balance);
}

class Item {
  final String id;
  final String name;
  final double price;

  Item(this.id, this.name, this.price);
}

class OrderItem {
  String name;
  int quantity;

  OrderItem(this.name, this.quantity);
}

class Order {
  final String id;
  final String clientName;
  final double total;
  final String date;
  final String status;

  Order(this.id, this.clientName, this.total, this.date, this.status);
}

class MobileOrderApp extends StatefulWidget {
  @override
  _MobileOrderAppState createState() => _MobileOrderAppState();
}

class _MobileOrderAppState extends State<MobileOrderApp> {
  List<Client> clients = [
    Client('1', 'Alice Johnson', '123 Main St, Anytown, USA', 1500),
    Client('2', 'Bob Smith', '456 Elm St, Somewhere, USA', 2300),
    Client('3', 'Charlie Brown', '789 Oak St, Nowhere, USA', 800),
    Client('4', 'Diana Prince', '101 Pine St, Everywhere, USA', 3000),
    Client('5', 'Ethan Hunt', '202 Maple St, Anywhere, USA', 1200),
  ];

  List<Item> items = [
    Item('1', 'Widget A', 10),
    Item('2', 'Gadget B', 20),
    Item('3', 'Doohickey C', 15),
    Item('4', 'Thingamajig D', 25),
    Item('5', 'Whatchamacallit E', 30),
  ];

  List<Order> orders = [
    Order('1', 'Alice Johnson', 50, '2023-05-01', 'completed'),
    Order('2', 'Bob Smith', 75, '2023-05-02', 'pending'),
    Order('3', 'Charlie Brown', 100, '2023-05-03', 'cancelled'),
    Order('4', 'Diana Prince', 125, '2023-05-04', 'completed'),
    Order('5', 'Ethan Hunt', 150, '2023-05-05', 'pending'),
  ];

  List<OrderItem> orderItems = [];
  String selectedClient = '';
  String paymentMethod = '';
  String searchTerm = '';

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mobile Order App'),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          buildClients(),
          buildOrders(),
          buildNewOrder(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Clients',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_shopping_cart),
            label: 'New Order',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

  Widget buildClients() {
    List<Client> filteredClients = clients
        .where((client) =>
            client.name.toLowerCase().contains(searchTerm.toLowerCase()) ||
            client.address.toLowerCase().contains(searchTerm.toLowerCase()))
        .toList();

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Search Clients',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                searchTerm = value;
              });
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredClients.length,
            itemBuilder: (context, index) {
              Client client = filteredClients[index];
              return ListTile(
                title: Text(client.name),
                subtitle: Text(client.address),
                onTap: () {
                  setState(() {
                    selectedClient = client.id;
                    _selectedIndex = 2; // Switch to new order view
                  });
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildOrders() {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return ListTile(
          title: Text(order.clientName),
          subtitle: Text(
              'Total: \$${order.total.toStringAsFixed(2)} - Date: ${order.date}'),
          trailing: Chip(
            label: Text(
              order.status.toUpperCase(),
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: order.status == 'completed'
                ? Colors.green
                : order.status == 'pending'
                    ? Colors.orange
                    : Colors.red,
          ),
          onTap: () {
            // Implementar navegación a detalles de orden si es necesario
            print('Tapped on Order: ${order.id}');
          },
        );
      },
    );
  }

  Widget buildNewOrder() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // DropdownButton<String>(
          //   value: selectedClient,
          //   hint: Text("Select Client"),
          //   onChanged: (String? newValue) {
          //     setState(() {
          //       selectedClient = newValue!;
          //     });
          //   },
          //   items: clients.map<DropdownMenuItem<String>>((Client client) {
          //     return DropdownMenuItem<String>(
          //       value: client.id,
          //       child: Text(client.name),
          //     );
          //   }).toList(),
          // ),
          SizedBox(height: 20),
          ...items
              .map((item) => CheckboxListTile(
                    title: Text(item.name),
                    subtitle: Text('\$${item.price.toStringAsFixed(2)}'),
                    value:
                        orderItems.any((element) => element.name == item.name),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value!) {
                          orderItems.add(OrderItem(item.name, 1));
                        } else {
                          orderItems.removeWhere(
                              (element) => element.name == item.name);
                        }
                      });
                    },
                  ))
              .toList(),
          TextField(
            decoration: InputDecoration(
              labelText: "Payment Method",
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              paymentMethod = value;
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              print('Order submitted');
              // Aquí agregar lógica para enviar los datos al backend o a otra pantalla
            },
            child: Text('Submit Order'),
          ),
        ],
      ),
    );
  }
}
