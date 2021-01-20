import 'package:flutter/material.dart';
import 'package:prozone/src/ui/search.dart';

import '../provider_detail.dart';

class Routes {
  // Route name constants
  static const String SearchRoute = '/search';
  static const String ProviderDetails = '/provider-details';

  /// The map used to define our routes, needs to be supplied to [MaterialApp]
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      Routes.SearchRoute: (context) => SearchView(),
      Routes.ProviderDetails: (context) => ProviderDetail(),
    };
  }
}
