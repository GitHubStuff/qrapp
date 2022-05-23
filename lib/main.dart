import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'classes/random_string.dart' as str;
import 'screens/qr_generator.dart';
import 'screens/qr_scanner.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Superformula Demo Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'Tap Button for options',
            ),
          ],
        ),
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        overlayColor: Colors.black,
        overlayOpacity: 0.45,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.qr_code),
            label: 'Generate QR Code',
            onTap: () {
              final String randomText = str.getRandomString(15);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QRGenerator(qrString: randomText),
                ),
              );
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.camera),
            label: 'Scan QR Code',
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const QRScanner()));
            },
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
