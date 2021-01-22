import 'package:prozone/src/models/state.dart';
import 'package:prozone/src/models/state_model.dart';
import 'package:prozone/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class ProviderStateBloc {
  final PublishSubject _providerStateController =
      PublishSubject<List<StateModel>>();

  Stream get providerState => _providerStateController.stream;

  void fetchProviderStates() async {
    State state = await repository.fetchProviderStates();
    if (state is SuccessState) {
      _providerStateController.sink.add(state.data);
    } else if (state is ErrorState) {
      _providerStateController.sink.addError(state.msg);
    }
  }

  void dispose() {
    _providerStateController.close();
  }
}

final providerStateBloc = ProviderStateBloc();
