import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ruta'),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            IconButton(
                onPressed: () => context.push("/local"),
                icon: const Icon(Icons.local_activity)),
          ],
        ),
      ),
      drawerDragStartBehavior: DragStartBehavior.start,
    );
  }
}
