import 'package:covid_barcode/src/db/visit.dart';

class BulkTestData {
  Future<void> bulkLoadVisits(int count) async {
    for(var i = 1; i <= count; i++) {
      await Visit(
        code: 'code' + i.toString(),
        name: 'Test ' + i.toString(),
        address: 'New Zealand',
        startDate: DateTime.now().add(Duration(days: (i % 4) * -1))
      ).createOrUpdate();
    }
  }
}