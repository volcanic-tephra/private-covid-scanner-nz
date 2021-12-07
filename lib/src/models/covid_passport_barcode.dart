import 'package:covid_barcode/src/models/barcode.dart';
import 'package:covid_barcode/src/models/cose.dart';

/// New Zealand covid bar code scan Json object
class CovidPassportBarcode implements Barcode {
  static RegExp _barcode = RegExp(r'^NZCP:\/\d\/(.*)');

  final Cose<CovidPassportSubject> cose;
  final String raw;

  CovidPassportBarcode(this.cose, this.raw);

  static bool canDecode(String raw) {
    return raw.startsWith('NZCP:');
  }

  BarcodeType get type {
    return BarcodeType.passport;
  }

  /// Convert a raw barcode scan string to instance. The bar code is in format
  /// NZCP:/<version-identifier>/<base32-encoded-CWT>
  static CovidPassportBarcode from(String raw) {
    var matches = _barcode.firstMatch(raw);
    if (matches == null) {
      throw Exception('Not a New Zealand Covid passport barcode');
    }

    String token = matches.group(1) ?? '';
    if (token.length == 0) {
      throw Exception('No token section found');
    }

    return CovidPassportBarcode(Cose<CovidPassportSubject>.from(token), raw);
  }
}