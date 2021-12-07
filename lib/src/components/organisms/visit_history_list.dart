
import 'package:flutter/material.dart';
import 'package:covid_barcode/src/db/visit.dart';
import 'package:covid_barcode/src/models/visits_controller.dart';
import 'package:covid_barcode/src/components/molecules/visit_card.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class VisitHistoryList extends StatelessWidget {
  VisitHistoryList({Key? key}) : super(key: key);

  List<Widget> _buildRows(BuildContext context, List<Visit> visits) {
    String formatDate(DateTime date) =>
        new DateFormat("EEE, MMM d, yyyy").format(date);

    final List<Widget> items = [];
    String header = '';

    for (var visit in visits) {
      // Add group header if date changes
      if (header != formatDate(visit.startDate)) {
        header = formatDate(visit.startDate);
        items.add(
            Container(
                height: 60,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(header, style: Theme.of(context).textTheme.headline3)
                    ]
                )
            )
        );
      }

      items.add(
          Container(
              height: 100,
              child: VisitCard(visit)
          )
      );
    }

    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<VisitsController>(
      builder: (context, visits, child) {
        if (visits.items.length == 0) {
          return Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                        child: Text("No history of visits")
                    )
                  ]
              )
          );
        }

        return ListView(
                  padding: const EdgeInsets.all(8),
                  children: this._buildRows(context, visits.items)
        );
      }
    );
  }
}


