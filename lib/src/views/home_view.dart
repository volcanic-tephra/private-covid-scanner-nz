import 'package:covid_barcode/src/db/passport.dart';
import 'package:covid_barcode/src/db/visit.dart';
import 'package:flutter/material.dart';
import 'package:covid_barcode/src/components/templates/common_page.dart';
import 'package:covid_barcode/src/components/organisms/passport_history_list.dart';
import 'package:covid_barcode/src/components/organisms/visit_history_list.dart';
import 'package:provider/provider.dart';
import 'package:covid_barcode/src/models/visits_controller.dart';
import 'package:covid_barcode/src/models/passports_controller.dart';

class HomeView extends StatefulWidget {
  static const routeName = '/';

  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Passport> _passports = [];
  List<Visit> _visits = [];

  Future<void> _getPassports() async {
    try {
      final passports = await Passport.list(0, limit: 4);

      setState(() {
        this._passports.clear();
        this._passports.addAll(passports);
      });
    } catch (ex) {
      print(ex);
    }
  }

  Future<void> _getVisits() async {
    try {
      final visits = await Visit.list(0, limit: 2);

      setState(() {
        this._visits.clear();
        this._visits.addAll(visits);
      });
    } catch (ex) {
      print(ex);
    }
  }

  @override
  void initState() {
    this._getPassports();
    this._getVisits();
  }

  @override
  Widget build(BuildContext context) {
    return CommonView(
      Container(
        child: Column(
          children: [
            _buildPassports(),
            Divider(
              height: 3,
            ),
            _buildVisits()
          ]
        )
      )
    );
  }

  Widget _buildPassports() {
    return SingleChildScrollView(
        child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: MediaQuery
                .of(context)
                .size
                .height * 0.4),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                verticalDirection: VerticalDirection.down,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 5.0),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text("Passports", style: Theme.of(context).textTheme.headline1),
                    ),
                  ),
                  Expanded(child: ChangeNotifierProvider(
                    create: (context) => PassportsController(this._passports)
                                          ..addListener(this._getPassports),
                    child: PassportHistoryList(),
                  ))
                ])
        )
    );
  }

  Widget _buildVisits() {
    return SingleChildScrollView(
        child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: MediaQuery
                .of(context)
                .size
                .height * 0.4),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                verticalDirection: VerticalDirection.down,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 5.0),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text("Recent Visits", style: Theme.of(context).textTheme.headline1),
                    ),
                  ),
                  Expanded(
                      child: ChangeNotifierProvider(
                        create: (context) => VisitsController(this._visits)
                                                ..addListener(this._getVisits),
                        child: VisitHistoryList(),
                  ))
                ])
        )
    );
  }

}
