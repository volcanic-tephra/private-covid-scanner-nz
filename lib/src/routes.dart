import 'package:flutter/material.dart';
import 'package:covid_barcode/src/views/scan_capture_view.dart';
import 'package:covid_barcode/src/views/scan_visit_preview_view.dart';
import 'package:covid_barcode/src/views/scan_passport_preview_view.dart';
import 'package:covid_barcode/src/views/passport_history_list_view.dart';
import 'package:covid_barcode/src/views/unknown_route_view.dart';
import 'package:covid_barcode/src/views/visit_history_list_view.dart';
import 'package:covid_barcode/src/views/home_view.dart';

/// Application route management
class Routes {

  /// All application named routes
  static Map<String, Widget Function(BuildContext)> routes() {
    return {
      HomeView.routeName: (context) => HomeView(),
      ScannerCaptureView.routeName: (context) => ScannerCaptureView(),
      ScanVisitPreviewView.routeName: (context) => ScanVisitPreviewView(),
      VisitHistoryListView.routeName: (context) => VisitHistoryListView(),
      ScanPassportPreviewView.routeName: (context) => ScanPassportPreviewView(),
      PassportHistoryListView.routeName: (context) => PassportHistoryListView()
      };
  }

  /// Default unknown route builder
  static MaterialPageRoute unknown(RouteSettings settings) {
    return MaterialPageRoute(
        builder: (context) => UnknownRouteView(name: settings.name)
        );
  }
}
