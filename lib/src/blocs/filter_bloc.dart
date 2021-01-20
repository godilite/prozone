import 'package:prozone/src/models/provider_type.dart';
import 'package:prozone/src/models/state.dart';
import 'package:prozone/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class FilterBloc {
  final PublishSubject _typeController = PublishSubject<List<ProviderType>>();
  final PublishSubject _statusController = PublishSubject<List>();

  Stream get types => _typeController.stream;
  Stream get status => _statusController.stream;

  void fetchProviderTypes() async {
    State state = await repository.fetchProviderType();
    if (state is SuccessState) {
      _typeController.sink.add(state.data);
    } else if (state is ErrorState) {
      _typeController.sink.addError(state.msg);
    }
  }

  void fetchStatus() async {
    List status = await repository.fetchStatus();
    _statusController.sink.add(status);
  }

  void dispose() {
    _typeController.close();
    _statusController.close();
  }
}
