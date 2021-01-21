import 'package:prozone/src/models/provider_type.dart';
import 'package:prozone/src/models/state.dart';
import 'package:prozone/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class ProviderTypeBloc {
  final PublishSubject _providerTypeController =
      PublishSubject<List<ProviderType>>();

  Stream get providerType => _providerTypeController.stream;

  void fetchProviderType() async {
    State state = await repository.fetchProviderType();
    if (state is SuccessState) {
      _providerTypeController.sink.add(state.data);
    } else if (state is ErrorState) {
      _providerTypeController.sink.addError(state.msg);
    }
  }

  void dispose() {
    _providerTypeController.close();
  }
}

final providerTypeBloc = ProviderTypeBloc();
