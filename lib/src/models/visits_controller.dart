import 'dart:collection';
import 'package:covid_barcode/src/db/visit.dart';
import 'package:flutter/foundation.dart';

class VisitsController extends ChangeNotifier {
  final List<Visit> _visits;

  VisitsController(this._visits);

  UnmodifiableListView<Visit> get items => UnmodifiableListView(_visits);

  Future<void> delete(Visit visit) async {
    if (_visits.contains(visit)) {
      await visit.delete();
      _visits.remove(visit);

      notifyListeners();
    }
  }
}