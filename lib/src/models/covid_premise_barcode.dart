import 'dart:convert' as convert;
import 'package:covid_barcode/src/models/barcode.dart';

/// New Zealand covid bar code scan Json object
class CovidPremiseBarcode implements Barcode {
  final String gln;
  final String opn;
  final String adr;
  final String ver;
  final String typ;

  CovidPremiseBarcode(this.gln, this.opn, this.adr, this.ver, this.typ);

  static bool canDecode(String raw) {
    return raw.startsWith('NZCOVIDTRACER:');
  }

  BarcodeType get type {
    return BarcodeType.premise;
  }

  CovidPremiseBarcode.fromJson(Map<String, dynamic> json) :
    gln = json['gln'],
    opn = json['opn'],
    adr = json['adr'],
    ver = json['ver'],
    typ = json['typ'];

  /// Convert a raw barcode scan string to instance. The bar code is in format
  /// NZCOVIDTRACER:{Base64 encoded Json}
  static CovidPremiseBarcode from(String data) {
    if (!data.startsWith('NZCOVIDTRACER')) {
      throw Exception('Not a New Zealand Covid tracer barcode');
    }

    var parts = data.split(':');
    if (parts.length != 2) {
      throw Exception('Invalid NZ Covid bar data');
    }

    // Base64 decode and convert to UTF8 string
    var decoded = convert.utf8.decode(convert.base64.decode(parts[1]));

    return CovidPremiseBarcode.fromJson(convert.jsonDecode(decoded));
  }
}