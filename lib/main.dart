import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saldoify/data/user_provider.dart';
import 'package:saldoify/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Saldoify",
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}