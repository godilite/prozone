import 'package:flutter_test/flutter_test.dart';
import 'package:prozone/src/blocs/filter_bloc.dart';
import 'package:prozone/src/models/provider_type.dart';

void main() async {
  group('Filter Bloc Test', () {
    test(
        "[Filter Bloc] fetchProviderTypes returns instance of ProviderType Lists",
        () async {
      filterBloc.fetchProviderTypes();
      filterBloc.types.listen(expectAsync1((value) {
        expect(value, isInstanceOf<List<ProviderType>>());
      }));
    });

    test("[Filter Bloc] fetchStatus returns instance of List", () async {
      filterBloc.fetchStatus();
      filterBloc.status.listen(expectAsync1((value) {
        expect(value, isInstanceOf<List>());
      }));
    });
  });
}
