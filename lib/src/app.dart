import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'ui/shared/routes.dart';
import 'ui/splash_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          textTheme: GoogleFonts.nunitoSansTextTheme(
            Theme.of(context).textTheme,
          ),
          appBarTheme: AppBarTheme(color: Colors.transparent, elevation: 0)),
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      home: Scaffold(
        body: Splash(),
      ),
      routes: Routes.getRoutes(),
    );
  }
}
