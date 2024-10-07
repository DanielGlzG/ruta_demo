import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class Conectiondisplay extends StatefulWidget {
  const Conectiondisplay({super.key});

  @override
  State<Conectiondisplay> createState() => _ConectiondisplayState();
}

class _ConectiondisplayState extends State<Conectiondisplay> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();

    // // Subscribe to the connectivity changed stream
    // _connectivitySubscription =
    //     _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
    //   // Update the connection status based on stream updates
    //   setState(() {
    //     _connectionStatus = result;
    //   });
    // }, onError: (e) {
    //   // Handle any errors here
    //   setState(() {
    //     _connectionStatus = ConnectivityResult.none;
    //   });
    // });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    if (!mounted) {
      return;
    }
    try {
      final result = await _connectivity.checkConnectivity();

      setState(() {
        _connectionStatus = result[0];
      });
    } catch (e) {
      setState(() {
        _connectionStatus = ConnectivityResult.none;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Icon(Icons.circle,
            color: _connectionStatus == ConnectivityResult.none
                ? Colors.red
                : Colors.green));
  }
}
