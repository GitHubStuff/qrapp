import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

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
            )
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
}
