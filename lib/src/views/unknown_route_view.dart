import 'package:flutter/material.dart';
import 'package:covid_barcode/src/components/templates/common_page.dart';

class UnknownRouteView extends StatelessWidget {
  final String? name;

  const UnknownRouteView({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonView(
        Column(children: [
      Center(
        child: Text("Unknown route $name"),
      )
    ]));
  }
}
