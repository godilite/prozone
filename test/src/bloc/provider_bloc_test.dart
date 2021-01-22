import 'package:flutter_test/flutter_test.dart';
import 'package:prozone/src/blocs/provider_bloc.dart';
import 'package:prozone/src/models/provider_model.dart';

void main() async {
  group('Provider Bloc Test', () {
    test("[ProviderBloc] fetchProviderList returns instance of Provider Lists",
        () async {
      providerBloc.fetchAllProviders();
      providerBloc.providers.listen(expectAsync1((value) {
        expect(value, isInstanceOf<List<ProviderModel>>());
      }));
    });
  });
}
