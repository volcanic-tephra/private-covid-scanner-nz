import 'package:flutter/material.dart';
import 'package:covid_barcode/src/db/passport.dart';
import 'package:intl/intl.dart';
import 'package:covid_barcode/src/models/passports_controller.dart';
import 'package:provider/provider.dart';

class PassportCard extends StatelessWidget {
  final Passport passport;

  PassportCard(this.passport) : super(key: Key(passport.id.toString()));

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
      content: Text("Are you sure you wish to delete this passport?"),
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
    return Consumer<PassportsController>(
            builder: (context, passports, child) =>
                Card(
                  child: ListTile(
                    leading: Icon(Icons.luggage),
                    title: Text(this.passport.firstName + ' ' + this.passport.familyName),
                    subtitle: Text(DateFormat("d/M/y").format(this.passport.expiryDate)),
                    onTap: () {
                      Navigator.pushNamed(context, '/scanned/passport', arguments: this.passport);
                    },
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      tooltip: 'Delete passport',
                      onPressed: () {
                        this._confirmDelete(context, () => passports.delete(this.passport));
                      },
                    ),
                  )
                )
    );
  }
}

