import 'package:flutter/material.dart';
import 'package:covid_barcode/src/components/templates/common_page.dart';
import 'package:covid_barcode/src/models/covid_premise_barcode.dart';
import 'package:covid_barcode/src/db/visit.dart';
import 'package:covid_barcode/src/util/geolocation.dart';
import 'package:covid_barcode/src/components/atoms/time_spinner.dart';
import 'package:intl/intl.dart';

class ScanVisitPreviewView extends StatefulWidget {
  ScanVisitPreviewView({Key? key}) : super(key: key);

  static const routeName = '/scanned/visit';

  @override
  _ScanVisitPreviewViewState createState() => _ScanVisitPreviewViewState();
}

class _ScanVisitPreviewViewState extends State<ScanVisitPreviewView> {
    Visit _visit = Visit.empty;

   _createVisit(CovidPremiseBarcode scanned) async {
     // If we've already created a Visit then don't do it again
     if (this._visit != Visit.empty) {
       return;
     }

     // Optionally get geo-location
     String? latitude;
     String? longitude;
     try {
       var position = await getCurrentPosition();
       latitude = position.latitude.toString();
       longitude = position.longitude.toString();
     } catch(ex) {
       // If we cannot get the GPS location then it does not matter
       print(ex);
     }

     final visit = Visit(
       name: scanned.opn,
       address: scanned.adr,
       code: scanned.gln,
       latitude: latitude,
       longitude: longitude,
       startDate: DateTime.now(),
       endDate: DateTime.now()
     );

     setState(() {
        this._visit = visit;
     });
   }

   _save() async {
     try {
       await this._visit.createOrUpdate();
       Navigator.pushNamed(context, '/');
     } catch(ex) {
       // TODO Handle error
       print(ex);
     }
   }

   void _onDateChange(DateTime endDate) {
    // Create another visit mutating by end date.
    this._visit = this._visit.from(endDate: endDate);

    // Note, that we do not do a setState, as the view has already updated
   }

  @override
  Widget build(BuildContext context) {
    _createVisit(ModalRoute.of(context)!.settings.arguments
                  as CovidPremiseBarcode);

    if (this._visit == Visit.empty) {
      return CommonView(
          Container()
      );
    }

    return CommonView(
      Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Icon(Icons.store, size: 120)
            ),
            Container(
                child: Text("You are currently checked in at", style: Theme.of(context).textTheme.headline2)
            ),
            Container(
                margin: const EdgeInsets.only(top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(this._visit.name, style: Theme.of(context).textTheme.headline1),
                  Text(this._visit.address, style: Theme.of(context).textTheme.headline2),
                  Text(DateFormat("d/M/y").format(this._visit.startDate), style: Theme.of(context).textTheme.headline2)
                ]
              )
            ),
            Divider(
              height: 50,
              thickness: 2
            ),
            Container(
                child: Text("You will be checked out at", style: Theme.of(context).textTheme.headline2)
            ),
            Container(
                margin: const EdgeInsets.only(top: 8),
                child: TimeSpinner(this._visit.endDate, onChange: this._onDateChange,)
            ),
            Spacer(),
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              child: ElevatedButton.icon(
                label: Text("Save"),
                icon: Icon(Icons.save),
                onPressed: () {
                  this._save();
                },
              )
            ),
            Spacer()
          ]
        )
      )
    );
  }
}