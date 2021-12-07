import 'package:flutter/material.dart';
import 'package:covid_barcode/src/components/atoms/covid_stripe.dart' as banner;
import 'package:covid_barcode/src/components/molecules/bottom_navigation.dart' as navigation;

class CommonView extends StatelessWidget {
  final Widget body;

  CommonView(this.body);

  PreferredSizeWidget _getAppBar(BuildContext context) {
    final size = Size.fromHeight(50);
    return PreferredSize(
        preferredSize: size,
        child: Container(
            height: size.height,
            child: CustomPaint(painter: banner.CovidStripe())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: this._getAppBar(context),
        body: Center(
          child: this.body
        ),
        bottomNavigationBar: navigation.BottomNavigation());
  }
}