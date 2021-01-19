import 'package:prozone/src/models/state.dart';
import 'package:prozone/src/resources/provider_api_provider.dart';

import 'filter_provider.dart';

class Repository {
  final ProviderApiProvider _providerApiProvider = ProviderApiProvider();
  final FilterProvider _filterProvider = FilterProvider();

  Future<State> fetchProviderList() => _providerApiProvider.fetchProviderList();

  Future<State> searchProviderByName(String name) =>
      _providerApiProvider.searchProviderByName(name);

  Future<State> fetchProviderType() => _filterProvider.fetchProviderType();
}

final repository = Repository();
