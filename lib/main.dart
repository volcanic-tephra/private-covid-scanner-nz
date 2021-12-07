import 'package:flutter/material.dart';
import 'src/db/database.dart';
import 'src/themes.dart' as theme;
import 'src/routes.dart' as navigation;

/// Everything starts here
void main() async {
  // Initialise widget binding before initialising database manager
  WidgetsFlutterBinding.ensureInitialized();

  // Initialise database on start-up
  await DbManager().initialise();

  //await BulkTestData().bulkLoadVisits(30);
  runApp(CovidTracerApp());
}

/// Main covid tracer app using Google's material UI
class CovidTracerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        title: 'Covid Tracer',
        theme: theme.current,
        initialRoute: '/',
        supportedLocales: [
          Locale("en", "NZ")
        ],
        routes: navigation.Routes.routes(),
        onUnknownRoute: navigation.Routes.unknown);
  }
}
