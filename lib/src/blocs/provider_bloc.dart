import 'package:prozone/src/models/provider_model.dart';
import 'package:prozone/src/models/state.dart';
import 'package:prozone/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class ProviderBloc {
  final PublishSubject _providersController =
      PublishSubject<List<ProviderModel>>();

  Stream get providers => _providersController.stream;

  void fetchAllProviders() async {
    State state = await repository.fetchProviderList();
    if (state is SuccessState) {
      _providersController.sink.add(state.data);
    } else if (state is ErrorState) {
      _providersController.sink.addError(state.msg);
    }
  }

  void dispose() {
    _providersController.close();
  }
}

final providerBloc = ProviderBloc();
