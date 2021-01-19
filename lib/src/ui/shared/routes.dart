import 'package:flutter/material.dart';
import 'package:prozone/src/ui/search.dart';

class Routes {
  // Route name constants
  static const String SearchRoute = '/search';

  /// The map used to define our routes, needs to be supplied to [MaterialApp]
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      Routes.SearchRoute: (context) => SearchView(),
    };
  }
}
