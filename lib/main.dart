import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:qrapp/screens/qr_generator.dart';
import 'package:qrapp/services/get_service.dart';

import 'screens/my_home_page.dart';
import 'screens/network_qr.dart';
import 'screens/qr_scanner.dart';

void main() {
  return runApp(ModularApp(module: AppModule(), child: const MyApp()));
}

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton((i) => FakeService()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => const MyHomePage(title: 'Superformula Demo Page')),
        ChildRoute(QRScanner.route, child: (_, __) => const QRScanner()),
        ChildRoute(QRGenerator.route, child: (_, args) => QRGenerator(qrString: args.data)),
        ChildRoute(NetworkQR.route, child: (_, __) => NetworkQR()),
      ];
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}
