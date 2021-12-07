import 'package:covid_barcode/src/models/visits_controller.dart';
import 'package:flutter/material.dart';
import 'package:covid_barcode/src/db/visit.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class VisitCard extends StatelessWidget {
  final Visit visit;

  VisitCard(this.visit) : super(key: Key(visit.id.toString()));

  _confirmDelete(BuildContext context, Function() doDelete) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Delete"),
      onPressed:  () {
        Navigator.of(context).pop();
        doDelete();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("AlertDialog"),
      content: Text("Are you sure you wish to delete this visit?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<VisitsController>(
        builder: (context, visits, child) =>
          Card(
              child: ListTile(
                leading: Icon(Icons.event),
                title: Text(this.visit.name),
                subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(this.visit.address),
                      Container(
                          margin: const EdgeInsets.only(top: 5.0),
                          child: Text("${DateFormat("H:mm:s").format(this.visit.startDate)} to ${DateFormat("H:mm:s").format(this.visit.endDate)}")
                      )
                    ]),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  tooltip: 'Delete Visit',
                  onPressed: () {
                    _confirmDelete(context, () => visits.delete(this.visit));
                  },
                ),
              )
          )
        );
  }
}