import 'package:flutter/material.dart';
import 'package:covid_barcode/src/components/templates/common_page.dart';
import 'package:covid_barcode/src/db/visit.dart';
import 'package:covid_barcode/src/components/organisms/visit_history_list.dart';
import 'package:provider/provider.dart';
import 'package:covid_barcode/src/models/visits_controller.dart';

class VisitHistoryListView extends StatefulWidget {
  VisitHistoryListView({Key? key}) : super(key: key);

  static const routeName = '/history/visit';

  @override
  _VisitHistoryListViewState createState() => _VisitHistoryListViewState();
}

class _VisitHistoryListViewState extends State<VisitHistoryListView> {
  List<Visit> visits = [];
  int start = 0;
  static const PAGE_SIZE=20;
  bool hasMore = true;

  void _nextPage() async {
    try {
      final page = await Visit.list(start, limit: PAGE_SIZE);
      hasMore = page.length == PAGE_SIZE;
      start += PAGE_SIZE + 1;

      setState(() {
        visits.addAll(page);
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
    _nextPage();
  }

  @override
  Widget build(BuildContext context) {
    return CommonView(
      ChangeNotifierProvider(
        create: (context) => VisitsController(this.visits),
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
              Expanded(child: VisitHistoryList())
            ])

      )
    );
  }
}


