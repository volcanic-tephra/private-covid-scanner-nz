import 'package:covid_barcode/src/db/passport.dart';
import 'package:flutter/material.dart';
import 'package:covid_barcode/src/components/templates/common_page.dart';
import 'package:covid_barcode/src/models/covid_passport_barcode.dart';
import 'package:covid_barcode/src/components/organisms/passport_preview.dart';

class ScanPassportPreviewView extends StatefulWidget {
  ScanPassportPreviewView({Key? key}) : super(key: key);

  static const routeName = '/scanned/passport';

  @override
  _ScanPassportPreviewViewState createState() => _ScanPassportPreviewViewState();
}

class _ScanPassportPreviewViewState extends State<ScanPassportPreviewView> {
  Passport _passport = Passport.empty;
  bool _canSave = false;

  _save() async {
    try {
      if (this._passport != Passport.empty) {
        await this._passport.createOrUpdate();
      }

      Navigator.pushNamed(context, '/');
    } catch(ex) {
      // TODO Handle error
      print(ex);
    }
  }

  // One off state initialiser than cannot be called from initState as context is not fully accessible
  Future<void> _init() async {
    if (_passport != Passport.empty) {
      return;
    }
    
    final data = ModalRoute
        .of(context)!
        .settings
        .arguments;

    Passport passport;
    bool canSave;
    if (data is CovidPassportBarcode) {
      passport = Passport.fromBarcode(data);
      canSave = (await Passport.findByUuid(passport.uuid)) == null;
    } else if (data is Passport) {
      passport = data;
      canSave = passport.id == null;
    } else {
      throw Exception('Invalid data');
    }

    setState(() {
      _passport = passport;
      _canSave = canSave;
    });
  }

  @override
  Widget build(BuildContext context) {
    _init();

    if (_passport == Passport.empty) {
      return CommonView(
        Container(child: Text('Loading'))
      );
    }

    final saveBtn = Container(
          child: Align(
              alignment: Alignment.center,
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  margin: const EdgeInsets.all(5),
                  child: ElevatedButton.icon(
                        label: Text("Save"),
                        icon: Icon(Icons.save),
                        onPressed: () {
                          this._save();
                        },
          ))
        )
      );

    return CommonView(
        Container(
            child: FractionallySizedBox(
              widthFactor: 0.9,
              child: Column(
                  children: [
                    PassportPreview(_passport),
                    Spacer(),
                    if(_canSave) saveBtn
                  ]
              )
            )
        )
    );
  }
}