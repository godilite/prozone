import 'package:prozone/src/models/provider_type.dart';
import 'package:prozone/src/models/state.dart';
import 'package:prozone/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class FilterBloc {
  final PublishSubject _typeController = PublishSubject<List<ProviderType>>();

  Stream get types => _typeController.stream;

  void fetchFilters() async {
    State state = await repository.fetchProviderType();
    if (state is SuccessState) {
      _typeController.sink.add(state.data);
    } else if (state is ErrorState) {
      _typeController.sink.addError(state.msg);
    }
  }

  void dispose() {
    _typeController.close();
  }
}
