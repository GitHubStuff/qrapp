import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRGenerator extends StatefulWidget {
  static const route = '/QRGenerator';
  
  final String qrString;

  const QRGenerator({Key? key, required this.qrString}) : super(key: key);

  @override
  State<QRGenerator> createState() => _QRGenerator();
}

class _QRGenerator extends State<QRGenerator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              widget.qrString,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline5,
            ),
            QrImage(data: widget.qrString),
          ],
        ),
      ),
    );
  }
}
