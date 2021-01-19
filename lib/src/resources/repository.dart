import 'package:prozone/src/models/state.dart';
import 'package:prozone/src/resources/provider_api_provider.dart';

class Repository {
  final ProviderApiProvider _providerApiProvider = ProviderApiProvider();
  Future<State> fetchProviderList() => _providerApiProvider.fetchProviderList();
  Future<State> searchProviderByName(String name) =>
      _providerApiProvider.searchProviderByName(name);
}

final repository = Repository();
