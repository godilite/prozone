import 'package:flutter/material.dart';
import 'package:prozone/src/ui/provider_list.dart';

import 'ui/shared/routes.dart';

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          appBarTheme: AppBarTheme(color: Colors.transparent, elevation: 0)),
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      home: Scaffold(
        body: ProviderList(),
      ),
      routes: Routes.getRoutes(),
    );
  }
}
