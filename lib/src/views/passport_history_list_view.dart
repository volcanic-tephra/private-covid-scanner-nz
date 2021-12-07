import 'package:flutter/material.dart';
import 'package:covid_barcode/src/components/templates/common_page.dart';
import 'package:covid_barcode/src/db/passport.dart';
import 'package:covid_barcode/src/components/organisms/passport_history_list.dart';
import 'package:provider/provider.dart';
import 'package:covid_barcode/src/models/passports_controller.dart';

class PassportHistoryListView extends StatefulWidget {
  PassportHistoryListView({Key? key}) : super(key: key);

  static const routeName = '/history/passport';

  @override
  _PassportHistoryListViewState createState() => _PassportHistoryListViewState();
}

class _PassportHistoryListViewState extends State<PassportHistoryListView> {
  List<Passport> passports = [];
  int start = 0;
  static const PAGE_SIZE=20;
  bool hasMore = true;

  void _nextPage() async {
    try {
      final page = await Passport.list(start, limit: PAGE_SIZE);
      hasMore = page.length == PAGE_SIZE;
      start += PAGE_SIZE + 1;

      setState(() {
        passports.addAll(page);
      });
    } catch (ex) {
      print('Failed to retrieve page: $ex');
    }
  }

  @override
  void initState() {
    _nextPage();
  }

  void _loadMore() {

  }

  @override
  Widget build(BuildContext context) {
    return CommonView(
        ChangeNotifierProvider(
            create: (context) => PassportsController(this.passports),
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
                  Expanded(child: PassportHistoryList())
                ])
        )
    );
  }
}


