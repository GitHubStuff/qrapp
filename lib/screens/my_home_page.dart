import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:qrapp/screens/network_qr.dart';

import 'qr_scanner.dart';

class MyHomePage extends StatefulWidget {
  static const route = '/';

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
              Modular.to.pushNamed(NetworkQR.route);
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.camera),
            label: 'Scan QR Code',
            onTap: () {
              Modular.to.pushNamed(QRScanner.route);
            },
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
