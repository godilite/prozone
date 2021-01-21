import 'package:prozone/src/blocs/provider_bloc.dart';
import 'package:prozone/src/models/provider_type.dart';
import 'package:prozone/src/models/state.dart';
import 'package:prozone/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

import '../app.dart';

class FilterBloc {
  final BehaviorSubject _typeController = BehaviorSubject<List<ProviderType>>();
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

  List selectedProviderType = [];
  List selectedStatus = [];
  void saveFilters(String selected, id, String type) {
    if (type == 'provider_type') {
      selectedProviderType.add(id);
      return;
    }
    selectedStatus.add(selected);
  }

  void removeFilters(String selected, id, String type) {
    if (type == 'provider_type') {
      selectedProviderType.remove(id);
      return;
    }
    selectedStatus.remove(selected);
  }

  void applyFilters() async {
    if (selectedProviderType.isNotEmpty) {
      await repository.saveFilter([
        ...{...selectedProviderType}
      ], 'provider_type');
    }
    if (selectedStatus.isNotEmpty) {
      await repository.saveFilter([
        ...{...selectedStatus}
      ], 'status');
    }
    selectedProviderType.clear();
    selectedStatus.clear();
    providerBloc.fetchAllProviders();
    navigatorKey.currentState.pushNamed('/');
  }

  void resetFilter() async {
    await repository.resetFilter();
    filterBloc.fetchProviderTypes();

    navigatorKey.currentState.pushNamed('/');
  }

  void dispose() {
    _typeController.close();
    _statusController.close();
  }
}

final filterBloc = FilterBloc();
