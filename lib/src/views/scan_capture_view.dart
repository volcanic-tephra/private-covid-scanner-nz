import 'package:flutter/material.dart';
import 'package:scan/scan.dart';
import 'package:covid_barcode/src/components/templates/common_page.dart';
import 'package:covid_barcode/src/models/barcode_factory.dart';
import 'package:covid_barcode/src/models/barcode.dart';

class ScannerCaptureView extends StatefulWidget {
  static const routeName = '/scan';

  ScannerCaptureView({Key? key}) : super(key: key);

  @override
  _ScannerCaptureViewState createState() => _ScannerCaptureViewState();
}

class _ScannerCaptureViewState extends State<ScannerCaptureView> {
  ScanController _controller = ScanController();
  bool _torch = false;
  bool _scanning = true;

  void _onCapture(String data) {
    try {
      final scanned = BarcodeFactory.decode(data);

      if (scanned.type == BarcodeType.premise) {
        Navigator.pushNamed(context, '/scanned/visit', arguments: scanned);
      } else if (scanned.type == BarcodeType.passport) {
        Navigator.pushNamed(context, '/scanned/passport', arguments: scanned);
      }
    } catch (ex) {
      // TODO show modal of error message
      print(ex);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonView(
        Container(
        child: Column(children: [
          Container(
            height: 90,
            child: this._buttons(),
          ),
          Expanded(
              child: ScanView(
                  controller: _controller,
                  scanAreaScale: .8,
                  scanLineColor: Colors.orange,
                  onCapture: this._onCapture)
          )
        ])
    ));
  }

  void _toggleTorch() {
    _controller.toggleTorchMode();
    setState(() {
      this._torch = !this._torch;
    });
  }

  void _toogleScan() {
    setState(() {
      this._scanning = !this._scanning;
    });

    if (!this._scanning) {
      this._controller.pause();
    } else {
      this._controller.resume();
    }
  }

  Widget _buttons() {
    return SizedBox(height: 90,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton.icon(
              label: Text('Flash'),
              icon: Icon(this._torch ? Icons.flash_on : Icons.flash_off),
              onPressed: () {
                this._toggleTorch();
              },
            ),
            ElevatedButton.icon(
              label: Text(this._scanning ? "Pause" : "Resume"),
              icon: Icon(this._scanning ? Icons.pause : Icons.play_arrow),
              onPressed: () {
                this._toogleScan();
              },
            )
          ]
      )
    );
  }
}
