import 'dart:collection';
import 'package:covid_barcode/src/db/passport.dart';
import 'package:flutter/foundation.dart';

class PassportsController extends ChangeNotifier {
  final List<Passport> _passports;

  PassportsController(this._passports);

  UnmodifiableListView<Passport> get items => UnmodifiableListView(_passports);

  Future<void> delete(Passport passport) async {
    if (_passports.contains(passport)) {
      await passport.delete();
      _passports.remove(passport);

      notifyListeners();
    }
  }
}