import 'package:flutter/material.dart';
import 'package:prozone/src/ui/create_provider.dart';
import 'package:prozone/src/ui/image_upload_preview.dart';
import 'package:prozone/src/ui/provider_list.dart';
import 'package:prozone/src/ui/search.dart';

import '../provider_detail.dart';

class Routes {
  // Route name constants
  static const String Home = '/provider-list';
  static const String SearchRoute = '/search';
  static const String ProviderDetails = '/provider-details';
  static const String PreviewImage = '/image-upload';
  static const String CreateProviderRoute = '/create-provider';

  /// The map used to define our routes, needs to be supplied to [MaterialApp]
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      Routes.SearchRoute: (context) => SearchView(),
      Routes.ProviderDetails: (context) => ProviderDetail(),
      Routes.PreviewImage: (context) => ImageUploadPreview(),
      Routes.CreateProviderRoute: (context) => CreateProvider(),
      Routes.Home: (context) => ProviderList()
    };
  }
}
