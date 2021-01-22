import 'package:flutter_test/flutter_test.dart';
import 'package:prozone/src/blocs/provider_state_bloc.dart';
import 'package:prozone/src/models/state_model.dart';

void main() async {
  group('State Bloc Test', () {
    test(
        "[Filter Bloc] fetchProviderStates returns instance of StateModel Lists",
        () async {
      providerStateBloc.fetchProviderStates();
      providerStateBloc.providerState.listen(expectAsync1((value) {
        expect(value, isInstanceOf<List<StateModel>>());
      }));
    });
  });
}
