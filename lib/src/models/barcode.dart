enum BarcodeType {unknown, premise, passport}

abstract class Barcode {
  BarcodeType get type {
    return BarcodeType.unknown;
  }
}