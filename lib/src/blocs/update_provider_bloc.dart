import 'package:prozone/src/blocs/provider_bloc.dart';
import 'package:prozone/src/models/provider_type.dart';
import 'package:prozone/src/models/state_model.dart';
import 'package:prozone/src/resources/repository.dart';
import 'package:prozone/src/app.dart';
import 'package:rxdart/rxdart.dart';

class UpdateProviderBloc {
  final BehaviorSubject _addressController = BehaviorSubject<String>();
  final BehaviorSubject _activeStatusController = BehaviorSubject<String>();
  final BehaviorSubject _stateController = BehaviorSubject<StateModel>();
  final PublishSubject _loadingData = PublishSubject<bool>();
  final BehaviorSubject _ratingController = BehaviorSubject<String>();
  final BehaviorSubject _typeController = BehaviorSubject<ProviderType>();
  final BehaviorSubject _nameController = BehaviorSubject<String>();
  final BehaviorSubject _descriptionController = BehaviorSubject<String>();
  final BehaviorSubject _hasError = BehaviorSubject<String>();

  Function(String) get changeAddress => _addressController.sink.add;

  Function(StateModel) get changeState => _stateController.sink.add;

  Function(String) get changeActiveStatus => _activeStatusController.sink.add;

  Function(String) get changeDescription => _descriptionController.sink.add;

  Function(String) get changeName => _nameController.sink.add;

  Function(String) get changeRating => _ratingController.sink.add;

  Function(ProviderType) get changeType => _typeController.sink.add;

  Stream get address => _addressController.stream;

  Stream get name => _nameController.stream;

  Stream get description => _descriptionController.stream;

  Stream get type => _typeController.stream;

  Stream get rating => _ratingController.stream;

  Stream get state => _stateController.stream;

  Stream get activeStatus => _activeStatusController.stream;
  //Stream get image => _imageController.stream;

  Stream get hasError => _hasError.stream;

  Stream<bool> get loading => _loadingData.stream;

  void submit(id) async {
    final data = {
      "address": _addressController.value,
      "rating": _ratingController.value,
      "description": _descriptionController.value,
      "name": _nameController.value,
      "provider_type": _typeController.value,
      "state": _stateController.value,
      "active_status": _activeStatusController.value
    };

    //remove null keys or values
    data.removeWhere((key, value) => key == null || value == null);
    _loadingData.sink.add(true);

    await repository.updateProvider(data, id);
    _loadingData.sink.add(false);
    providerBloc.fetchAllProviders();
    navigatorKey.currentState.pop();
  }

  void dispose() {
    _addressController.close();
    _ratingController.close();
    _nameController.close();
    _typeController.close();
    _descriptionController.close();
    _loadingData.close();
    _hasError.close();
    _activeStatusController.close();
    _stateController.close();
  }
}

final updateProviderBloc = UpdateProviderBloc();
