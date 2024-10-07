import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'config/constants/environment.dart';
import 'config/db/sqliteDb.dart';
import 'config/router/app_router.dart';
import 'config/theme/app_theme.dart';

void main() async {
  await Environment.intEnvironment();
  WidgetsFlutterBinding.ensureInitialized();
  await SqliteDatasource.instance.init();
  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: "AIzaSyCw5EN4p5W695hFaNUTrsFazQGsTLP2II0",
    appId: 'id',
    messagingSenderId: 'sendid',
    projectId: "rutademo-889b7",
    storageBucket: "rutademo-889b7.appspot.com",
  ));
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
      routerConfig: appRouter,
    );
  }
}
