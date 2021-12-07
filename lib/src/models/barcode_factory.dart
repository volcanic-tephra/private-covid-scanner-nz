import 'package:covid_barcode/src/models/barcode.dart';
import 'package:covid_barcode/src/models/covid_passport_barcode.dart';
import 'package:covid_barcode/src/models/covid_premise_barcode.dart';

class BarcodeFactory {
  static Barcode decode(String raw) {
    if (CovidPassportBarcode.canDecode(raw)) {
      return CovidPassportBarcode.from(raw);
    }

    if (CovidPremiseBarcode.canDecode(raw)) {
      return CovidPremiseBarcode.from(raw);
    }

    throw Exception('Unknown barcode $raw');
  }
}