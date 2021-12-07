import 'package:flutter/material.dart';
import 'package:covid_barcode/src/db/passport.dart';
import 'package:covid_barcode/src/components/molecules/passport_card.dart';
import 'package:provider/provider.dart';
import 'package:covid_barcode/src/models/passports_controller.dart';

class PassportHistoryList extends StatelessWidget {
  PassportHistoryList({Key? key}) : super(key: key);

  List<Widget> _buildRows(BuildContext context, List<Passport> passports) {
    if (passports.length == 0) {
      return [Center(
          child: Row(
              children: [
                Text('No history')
              ]
          )
      )];
    }

    final List<Widget> items = passports.map( (passport) {
      return Container(
          height: 80,
          child: PassportCard(passport)
      );
    }).toList();

    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PassportsController>(
        builder: (context, passports, child) {
          return ListView(
                        padding: const EdgeInsets.all(8),
                        children: this._buildRows(context, passports.items)
                    );
        }
    );
  }
}


