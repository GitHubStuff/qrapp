// Uses the camera view to allow the user to line-up a QRCode and the class
// will automatically scan the QRCode.
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qrapp/screens/qr_generator.dart';

class QRScanner extends StatefulWidget {
  static const route = '/QRScanner';

  const QRScanner({Key? key}) : super(key: key);

  @override
  State<QRScanner> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<QRScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  Barcode? barcodeResult;
  QRViewController? qrViewController;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      qrViewController!.pauseCamera();
    } else if (Platform.isIOS) {
      qrViewController!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scanner'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 5,
              child: _qrView(),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: (barcodeResult != null) ? Text('Barcode Type: ${describeEnum(barcodeResult!.format)}   Data: ${barcodeResult!.code}') : const Text('Scan a code'),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: (barcodeResult != null)
                    ? _showQRButton()
                    : const SizedBox(
                        height: 46.0,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  dispose() {
    qrViewController?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    qrViewController = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        barcodeResult = scanData;
      });
    });
  }

  QRView _qrView() => QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
        overlay: QrScannerOverlayShape(
          cutOutSize: MediaQuery.of(context).size.width * 0.80,
          borderWidth: 5,
        ),
      );

  ElevatedButton _showQRButton() {
    final ButtonStyle style = ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
    return ElevatedButton(
      style: style,
      onPressed: () {
        Modular.to.pushNamed(QRGenerator.route, arguments: barcodeResult!.code);
      },
      child: const Text('Render'),
    );
  }
}
