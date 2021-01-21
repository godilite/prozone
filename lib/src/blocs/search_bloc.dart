import 'package:prozone/src/models/provider_model.dart';
import 'package:prozone/src/models/state.dart';
import 'package:prozone/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc {
  final BehaviorSubject _searchController = BehaviorSubject<String>();
  final PublishSubject _resultsController =
      PublishSubject<List<ProviderModel>>();
  Function(String) get addKeyword => _searchController.sink.add;
  Stream get results => _resultsController.stream;
  Stream get searchKeyword => _searchController.stream;

  void searchProviders() async {
    String name = _searchController.value;

    State state = await repository.searchProviderByName(name);
    if (state is SuccessState) {
      _resultsController.sink.add(state.data);
    } else if (state is ErrorState) {
      _resultsController.sink.addError(state.msg);
    }
  }

  void dispose() {
    _resultsController.close();
    _searchController.close();
  }
}

final searchBloc = SearchBloc();
