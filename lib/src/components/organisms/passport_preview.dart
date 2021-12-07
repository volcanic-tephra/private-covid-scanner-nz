import 'package:flutter/material.dart';
import 'package:covid_barcode/src/db/passport.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:intl/intl.dart';

class PassportPreview extends StatelessWidget {
  final Passport passport;

  PassportPreview(this.passport) : super(key: Key(passport.id.toString()));

  @override
  Widget build(BuildContext context) {
    return  Container(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10.0, bottom: 10),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text('My Vaccine Pass', style: Theme.of(context).textTheme.headline1),
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 5),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text('Name', style: Theme.of(context).textTheme.headline2),
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 10),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(passport.firstName + ' ' + passport.familyName, style: Theme.of(context).textTheme.headline2),
                ),
              ),
              Container(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Date of Birth ', style: Theme.of(context).textTheme.caption),
                        Text(DateFormat("d/M/y").format(passport.dob), style: Theme.of(context).textTheme.bodyText2),
                      ]
                  )
              ),
              Container(
                padding: EdgeInsets.only(bottom: 10),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: BarcodeWidget(
                      barcode: Barcode.qrCode(), // Barcode type and settings
                      data: passport.raw, // Content
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.width * 0.8,
                    )
                ),
              ),
              Container(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Not Before ', style: Theme.of(context).textTheme.caption),
                        Text(DateFormat("d/M/y").format(passport.issuedDate), style: Theme.of(context).textTheme.bodyText2),
                      ]
                  )
              ),
              Container(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Expires on ', style: Theme.of(context).textTheme.caption),
                        Text(DateFormat("d/M/y").format(passport.expiryDate), style: Theme.of(context).textTheme.bodyText2),
                      ]
                  )
              ),
              Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('You may be asked to show photo ID. For use in Aotearoa New Zealand. Cannot be used for international travel.',
                          style: Theme.of(context).textTheme.caption,
                          maxLines: 3,
                          overflow: TextOverflow.visible,),
                      ]
                  )
              )
            ]
          )
        );
  }
}