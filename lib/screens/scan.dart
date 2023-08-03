import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanScreen extends StatefulWidget {
  static const routeName = '/scan';
  @override
  _ScanScreen createState() => _ScanScreen();
}

class _ScanScreen extends State<ScanScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? _controller;

  @override
  void reassemble() {
    super.reassemble();
    _controller?.pauseCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 0, 0, 0.7), //默认颜色，太白了不好看
      body: Column(
        children: <Widget>[
          Expanded(
              flex: 5,
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
                overlay: QrScannerOverlayShape(),
              )),
          Expanded(
            flex: 1,
            child: Center(
              child: (result != null)
                  ? Text(
                      'Barcode Type: ${(result!.format)}   Data: ${result!.code}',
                      style: TextStyle(color: Colors.red),
                    )
                  : Text('Scan a code', style: TextStyle(color: Colors.red)),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    _controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }
}
